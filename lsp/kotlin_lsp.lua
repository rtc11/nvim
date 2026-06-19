-- update in :Mason
return {
    filetypes = { 'kotlin' },
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/intellij-server', '--stdio' },
    root_markers = {
        'settings.gradle.kts', -- Gradle (multi-project)
        'build.gradle.kts',    -- Gradle
        'workspace.json',      -- Used to integrate your own build system
    },
    settings = {
        kotlin = {
            compiler = {
                jvm = {
                    target = "21"
                }
            }
        }
    },
    on_attach = function(_, _)
        if vim.g._jar_uri_handler then return end
        vim.g._jar_uri_handler = true

        if vim.fn.executable("unzip") == 0 then
            vim.notify("kotlin_lsp: unzip not found on PATH", vim.log.levels.WARN)
        end

        local function set_buf_lines(buf, text, ft)
            local lines = vim.split(text, "\n", { trimempty = false })
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.bo[buf].buftype = "nofile"
            vim.bo[buf].modifiable = false
            vim.bo[buf].readonly = true
            vim.bo[buf].swapfile = false
            if ft then vim.bo[buf].filetype = ft end
        end

        local function unzip_one(jar, internal)
            local r = vim.system({ "unzip", "-p", jar, internal }):wait()
            if r.code == 0 and r.stdout and #r.stdout > 0 then return r.stdout end
            return nil
        end

        local function strip_inner(internal)
            -- Foo$Bar$Baz.class -> Foo.class
            return (internal:gsub("(/?[^/]+)%$[^/]+(%.class)$", "%1%2"))
        end

        vim.api.nvim_create_autocmd("BufReadCmd", {
            pattern = "jar://*",
            callback = function(ev)
                local jar_path, internal_path = ev.match:match("^jar://(.-)!/(.+)$")
                if not jar_path or not internal_path then
                    vim.notify("Could not parse jar URI: " .. ev.match, vim.log.levels.ERROR)
                    return
                end

                -- non-class: raw extract
                if not internal_path:match("%.class$") then
                    local txt = unzip_one(jar_path, internal_path)
                    if not txt then
                        vim.notify("Failed to extract " .. internal_path .. " from " .. jar_path, vim.log.levels.ERROR)
                        return
                    end
                    local ext = internal_path:match("%.(%w+)$")
                    local ft_map = { kt = "kotlin", java = "java", xml = "xml" }
                    set_buf_lines(ev.buf, txt, ext and (ft_map[ext] or ext) or nil)
                    return
                end

                -- .class: try sources jar (kt then java), with inner-class strip
                local sources_jar = jar_path:gsub("%.jar$", "-sources.jar")
                local outer = strip_inner(internal_path)
                local kt_path = outer:gsub("%.class$", ".kt")
                local java_path = outer:gsub("%.class$", ".java")

                local txt = unzip_one(sources_jar, kt_path)
                if txt then
                    set_buf_lines(ev.buf, txt, "kotlin")
                    return
                end
                txt = unzip_one(sources_jar, java_path)
                if txt then
                    set_buf_lines(ev.buf, txt, "java")
                    return
                end

                vim.notify(
                    "kotlin_lsp: no sources jar for " .. jar_path .. "!" .. internal_path
                        .. "\n  hint: enable downloadSources in build.gradle.kts or fetch sources via gradle",
                    vim.log.levels.WARN
                )
            end,
        })
    end,
}
