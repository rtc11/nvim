return {
    -- 
    --  show indent lines
    -- 
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    --
    -- Bottom-left text notifications
    --
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
    --
    -- UI hooks for vim.ui.select and vim.ui.input
    --
    {
        'stevearc/dressing.nvim',
        event = "VeryLazy"
    },
    --
    -- Status line
    --
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                --theme = 'onedark',
                --theme = 'catppuccin',
                --theme = 'nordic',
                theme = 'onenord',
                component_separators = '|',
                section_separators = '',
            }
        }
    },
    --
    -- Replaces UI for messages, cmdline and popupmenu
    --
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                nnc_renname = false,          -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        },
    }
}
