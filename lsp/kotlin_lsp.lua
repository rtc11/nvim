-- update in :Mason
return {
    filetypes = { 'kotlin' },
    cmd = { 'kotlin-lsp', '--stdio' },
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

        vim.api.nvim_create_autocmd("BufReadCmd", {
            pattern = "jar://*",
            callback = function(ev)
                local jar_path, internal_path = ev.match:match("^jar://(.-)!/(.+)$")
                if not jar_path or not internal_path then
                    vim.notify("Could not parse jar URI: " .. ev.match, vim.log.levels.ERROR)
                    return
                end

                local result = vim.system({ "unzip", "-p", jar_path, internal_path }):wait()
                if result.code ~= 0 then
                    vim.notify("Failed to extract from JAR: " .. (result.stderr or ""), vim.log.levels.ERROR)
                    return
                end

                local lines = vim.split(result.stdout, "\n", { trimempty = false })
                vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)

                vim.bo[ev.buf].buftype = "nofile"
                vim.bo[ev.buf].modifiable = false
                vim.bo[ev.buf].readonly = true
                vim.bo[ev.buf].swapfile = false

                local ext = internal_path:match("%.(%w+)$")
                if ext then
                    local ft_map = { kt = "kotlin", java = "java", xml = "xml" }
                    vim.bo[ev.buf].filetype = ft_map[ext] or ext
                end
            end,
        })
    end,
}

