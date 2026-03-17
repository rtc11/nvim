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
}

