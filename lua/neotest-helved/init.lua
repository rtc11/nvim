-- neotest-helved
--
-- A neotest adapter tailored for the helved-utbetaling monorepo.
--
-- Why this exists:
--   neotest-gradle calls `gradle properties --property testResultsDir` to
--   locate the JUnit XML report directory. In Gradle 8 that project property
--   is gone, so the command prints "null", and the adapter ends up looking
--   for "null/test" -> ENOENT.
--
-- This adapter:
--   * finds the nearest ancestor with a `build.gradle.kts` as the gradle
--     subproject root,
--   * finds the monorepo root by walking up to the dir with `settings.gradle.kts`,
--   * derives the Gradle project path (e.g. ":apps:utsjekk") from the relative
--     path between the two,
--   * runs `<root>/gradlew :apps:utsjekk:test --tests '<filter>'`,
--   * collects results from `<subproject>/build/test-results/test/*.xml`.
--
-- Test discovery (positions) and result parsing logic is borrowed from
-- neotest-gradle since it works fine for Kotlin sources -- only the project
-- directory + report directory + command building are different.

local lib = require("neotest.lib")
local xml = require("neotest.lib.xml")
local nio = require("nio")

local find_subproject = lib.files.match_root_pattern("build.gradle", "build.gradle.kts")
local find_root = lib.files.match_root_pattern("settings.gradle", "settings.gradle.kts")

local position_queries = require("neotest-gradle.position_queries")
local shared_utilities = require("neotest-gradle.hooks.shared_utilities")
local get_package_name = shared_utilities.get_package_name

local TEST_FILE_PATTERNS = { "Test%.kt$", "Test%.java$" }
local XML_FILE_SUFFIX = ".xml"
local STATUS_PASSED = "passed"
local STATUS_FAILED = "failed"

local M = { name = "helved-gradle" }

-- ---------------------------------------------------------------------------
-- root: monorepo root (dir with settings.gradle.kts)
-- ---------------------------------------------------------------------------
function M.root(dir)
    return find_root(dir)
end

-- ---------------------------------------------------------------------------
-- filter_dir: skip noise so discovery isn't slow
-- ---------------------------------------------------------------------------
function M.filter_dir(name, _, _)
    local skip = {
        ["build"] = true,
        [".gradle"] = true,
        [".git"] = true,
        [".idea"] = true,
        [".agents"] = true,
        ["node_modules"] = true,
        ["main"] = true, -- production sources, never tests in this repo
        ["migrations"] = true,
    }
    return not skip[name]
end

-- ---------------------------------------------------------------------------
-- is_test_file
-- ---------------------------------------------------------------------------
function M.is_test_file(file_path)
    for _, pattern in ipairs(TEST_FILE_PATTERNS) do
        if file_path:match(pattern) then
            return true
        end
    end
    return false
end

-- ---------------------------------------------------------------------------
-- discover_positions: reuse neotest-gradle's tree-sitter pipeline
-- ---------------------------------------------------------------------------
local function detect_filetype(path)
    if path:match("%.kt$") then return "kotlin" end
    if path:match("%.java$") then return "java" end
    return nil
end

local build_position = require("neotest-gradle.hooks.discover_positions.build_position")
local build_position_id = require("neotest-gradle.hooks.discover_positions.build_position_identifier")

function M.discover_positions(path)
    local ft = detect_filetype(path)
    if not ft then return nil end
    local query = position_queries[ft]
    if not query then return nil end

    return lib.treesitter.parse_positions(path, query, {
        build_position = build_position,
        position_id = build_position_id,
    })
end

-- ---------------------------------------------------------------------------
-- helpers for build_spec
-- ---------------------------------------------------------------------------

--- Convert a filesystem subproject dir into a Gradle project path.
---   /repo/apps/utsjekk -> ":apps:utsjekk"
local function gradle_project_path(monorepo_root, subproject_dir)
    local sep = lib.files.sep
    local rel = subproject_dir:sub(#monorepo_root + 1)
    -- strip leading sep
    if rel:sub(1, 1) == sep then rel = rel:sub(2) end
    -- strip trailing sep
    if rel:sub(-1) == sep then rel = rel:sub(1, -2) end
    if rel == "" then return "" end
    return ":" .. rel:gsub(sep, ":")
end

local function gradle_executable(monorepo_root)
    local wrapper = monorepo_root .. lib.files.sep .. "gradlew"
    if vim.fn.executable(wrapper) == 1 then return wrapper end
    return "gradle"
end

local function get_namespaces_of_tree(tree)
    local namespaces = {}
    for _, position in tree:iter() do
        if position.type == "namespace" then
            table.insert(namespaces, position)
        end
    end
    return namespaces
end

local function get_test_filter_arguments(tree, position)
    local arguments = {}
    if position.type == "test" or position.type == "namespace" then
        vim.list_extend(arguments, { "--tests", "'" .. position.id .. "'" })
    elseif position.type == "file" then
        for _, namespace in ipairs(get_namespaces_of_tree(tree)) do
            vim.list_extend(arguments, { "--tests", "'" .. namespace.id .. "'" })
        end
    elseif position.type == "dir" then
        -- run the whole subproject's tests, no filter
    end
    return arguments
end

-- ---------------------------------------------------------------------------
-- build_spec
-- ---------------------------------------------------------------------------
function M.build_spec(args)
    local position = args.tree:data()
    local subproject_dir = find_subproject(position.path)
    if not subproject_dir then
        return nil
    end
    local monorepo_root = find_root(subproject_dir) or subproject_dir
    local project_path = gradle_project_path(monorepo_root, subproject_dir)
    local gradle = gradle_executable(monorepo_root)

    local command = { gradle }
    if project_path ~= "" then
        table.insert(command, project_path .. ":test")
    else
        table.insert(command, "test")
    end
    vim.list_extend(command, get_test_filter_arguments(args.tree, position))

    -- always rerun even if Gradle thinks tests are up-to-date
    table.insert(command, "--rerun-tasks")
    -- richer stdout in the output panel
    table.insert(command, "--info")
    -- plain console keeps the "BUILD SUCCESSFUL / FAILED" summary readable
    -- in the output buffer and avoids raw ANSI escape sequences (which
    -- neotest's output viewer doesn't translate into colors).
    table.insert(command, "--console=plain")

    local results_dir = subproject_dir .. lib.files.sep
        .. "build" .. lib.files.sep
        .. "test-results" .. lib.files.sep
        .. "test"

    -- neotest reads this file and shows it when you press `o` on the run
    -- node (file/dir/namespace). Per-test output is attached separately
    -- in `results()` from <system-out>/<system-err> in the JUnit XML.
    local output_file = nio.fn.tempname()

    return {
        command = table.concat(command, " "),
        cwd = monorepo_root,
        context = {
            results_directory = results_dir,
            subproject_dir = subproject_dir,
            output_file = output_file,
        },
        output = output_file,
    }
end

-- ---------------------------------------------------------------------------
-- collect_results
-- ---------------------------------------------------------------------------

local function as_list(value)
    if value == nil then return {} end
    return (type(value) == "table" and #value > 0) and value or { value }
end

local function parse_xml_files_from_directory(directory_path)
    if vim.fn.isdirectory(directory_path) == 0 then
        return {}
    end
    local xml_files = lib.files.find(directory_path, {
        filter_dir = function(_) return false end, -- non-recursive: skip subdirs
    })
    local reports = {}
    for _, file_path in ipairs(xml_files) do
        if file_path:sub(-#XML_FILE_SUFFIX) == XML_FILE_SUFFIX then
            local ok, content = pcall(lib.files.read, file_path)
            if ok then
                local ok2, parsed = pcall(xml.parse, content)
                if ok2 then table.insert(reports, parsed) end
            end
        end
    end
    return reports
end

local function find_position_for_test_case(tree, test_case_node)
    local test_name = test_case_node._attr.name:gsub("%(.*%)$", "")
    local class_name = test_case_node._attr.classname or ""

    local candidate_ids = {
        class_name .. "." .. test_name,
        class_name:gsub("%$", ".") .. "." .. test_name,
    }

    for _, position in tree:iter() do
        if position then
            for _, candidate_id in ipairs(candidate_ids) do
                if position.id == candidate_id then
                    return position
                end
            end
        end
    end
    return nil
end

local function parse_error_from_failure_xml(failure_node, position)
    local err_type = failure_node._attr.type or ""
    local message = failure_node._attr.message or ""
    message = (message:gsub(err_type .. ".*\n", ""))

    local stack_trace = failure_node[1] or ""
    local package_name = get_package_name(position.path)
    local line_number

    for _, line in ipairs(vim.split(stack_trace, "[\r]?\n")) do
        local pattern = "^.*at.+" .. package_name .. ".*%(.+..+:(%d+)%)$"
        local match = line:match(pattern)
        if match then
            line_number = tonumber(match) - 1
            break
        end
    end

    return { message = message, line = line_number }
end

--- Restore real ANSI ESC bytes from XML-substituted ones.
---
--- XML 1.0 disallows the ESC byte (0x1B), so when Logback writes
--- ANSI-colored log lines into the JUnit `<system-out>` element, it
--- substitutes ESC (0x1B) with `?` (0x3F). The bytes we get back look
--- like `?[36m...?[0;39m`. We restore them to `\x1B[36m...\x1B[0;39m`
--- so neotest's terminal-channel-based output viewer can colorize
--- them natively (same path the Gradle run log uses).
---
--- The substitution is constrained to the SGR pattern `?[<digits/;>m`
--- (and a few related CSI letters) so we don't accidentally rewrite
--- legitimate `?[...]` text in test output.
local function restore_ansi(s)
    if s == nil or s == "" then return s end
    return (s:gsub("%?(%[[%d;]*[A-Za-z])", "\27%1"))
end

--- Pull text content out of an XML node parsed by neotest.lib.xml.
--- The parser stores text as either a bare string at index 1 or as
--- `node[1]`. Returns "" if there's nothing usable.
local function xml_text(node)
    if node == nil then return "" end
    if type(node) == "string" then return restore_ansi(node) end
    if type(node) == "table" then
        if type(node[1]) == "string" then return restore_ansi(node[1]) end
    end
    return ""
end

local function write_tmp(content)
    -- results() runs in a libuv fast context, where vim.fn.* is banned.
    -- nio.fn.* defers to the main loop safely.
    local path = nio.fn.tempname()
    local fd = assert(io.open(path, "w"))
    fd:write(content or "")
    fd:close()
    return path
end

function M.results(spec, strategy_result, tree)
    local results = {}
    local results_directory = spec.context and spec.context.results_directory
    if not results_directory then return results end

    -- NOTE: ANSI escape sequences from Logback / Gradle are intentionally
    -- preserved in both the run log and per-test outputs. The neotest
    -- output buffers are colorized via baleia.nvim (see plugins/test.lua).

    local reports = parse_xml_files_from_directory(results_directory)

    for _, report in ipairs(reports) do
        for _, test_suite_node in ipairs(as_list(report.testsuite)) do
            local suite_stdout = xml_text(test_suite_node["system-out"])
            local suite_stderr = xml_text(test_suite_node["system-err"])

            for _, test_case_node in ipairs(as_list(test_suite_node.testcase)) do
                local matched = find_position_for_test_case(tree, test_case_node)
                if matched then
                    local failure_node = test_case_node.failure
                    local status = failure_node == nil and STATUS_PASSED or STATUS_FAILED
                    local short = (failure_node or {}).message
                    local errs = failure_node
                        and { parse_error_from_failure_xml(failure_node, matched) }
                        or nil

                    -- Build a per-test output blob neotest will display when
                    -- you press `o` on the test node.
                    local case_stdout = xml_text(test_case_node["system-out"])
                    local case_stderr = xml_text(test_case_node["system-err"])
                    local failure_text = ""
                    if failure_node then
                        local msg = failure_node._attr and failure_node._attr.message or ""
                        local trace = xml_text(failure_node)
                        failure_text = "FAILURE: " .. msg .. "\n" .. trace .. "\n"
                    end

                    local parts = {}
                    if failure_text ~= "" then table.insert(parts, failure_text) end
                    if case_stdout ~= "" then
                        table.insert(parts, "--- stdout (test) ---\n" .. case_stdout)
                    end
                    if case_stderr ~= "" then
                        table.insert(parts, "--- stderr (test) ---\n" .. case_stderr)
                    end
                    if suite_stdout ~= "" then
                        table.insert(parts, "--- stdout (suite) ---\n" .. suite_stdout)
                    end
                    if suite_stderr ~= "" then
                        table.insert(parts, "--- stderr (suite) ---\n" .. suite_stderr)
                    end

                    local output_path
                    if #parts > 0 then
                        output_path = write_tmp(table.concat(parts, "\n"))
                    elseif strategy_result and strategy_result.output then
                        -- fall back to the full run's stdout file
                        output_path = strategy_result.output
                    end

                    results[matched.id] = {
                        status = status,
                        short = short,
                        errors = errs,
                        output = output_path,
                    }
                end
            end
        end
    end

    return results
end

return M
