-- Interface to treesitter (syntax highlighting)
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = false,
            ignore_install = { "cpp" },
            sync_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed  = {
                "kotlin",
                "rust",
                "ocaml",
                "c",
                "lua",
                "go",
                "toml",
                "json",
                "yaml",
                "python",
                "bash",
                "dockerfile",
                "gleam",
            }
        })
    end
}

-- If syntax highlighting is disabled, you can enable it with:
-- :TSDisable highlight
-- :TSEnable highlight
