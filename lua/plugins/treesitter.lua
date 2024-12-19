-- Interface to treesitter (syntax highlighting)
return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()

            local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
            parser_config.c3 = {
                install_info = {
                    url = "https://github.com/c3lang/tree-sitter-c3",
                    files = { "src/parser.c", "src/scanner.c" },
                    branch = "main",
                },
                auto_install = true,
                sync_install = true,
                filetype = "c3",
            }

            require "nvim-treesitter.configs".setup{
                auto_install = true,
                ensure_installed = {
                    "bash",
                    "c",
                    "c3",
                    "dockerfile",
                    "gleam",
                    "go",
                    "json",
                    "kotlin",
                    "lua",
                    "markdown",
                    "ocaml",
                    "python",
                    "query",
                    "rust",
                    "scala",
                    "toml",
                    "vim",
                    "yaml",
                },
                ignore_install = { "cpp", },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context", -- Optional: For better context display
    },
    {
        "nvim-treesitter/nvim-treesitter-context", -- Optional: For better context display
    },
}

-- If syntax highlighting is disabled, you can enable it with:
-- :TSDisable highlight
-- :TSEnable highlight
--
-- :InspecTree
--
-- Set filetype:
-- :set filetype=scala
