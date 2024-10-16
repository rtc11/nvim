return {

    ---------------------------------------------------------------------------
    -- File browser
    -----------------------------------------------------------------------------
    {
        'stevearc/oil.nvim',
        opts = {
            columns = { "icon" },
            view_options = {
                show_hidden = true,
            }
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '-', ':Oil<CR>', desc = 'Open Oil' },
        },
    },

    {
        "gcmt/vessel.nvim",
        config = function()
            require("vessel").setup({
                create_commands = true,
                commands = {
                    view_marks = "Marks",
                    view_jumps = "Jumps",
                    view_buffers = "Buffers"
                }
            })
        end
    },

    -----------------------------------------------------------------------------
    -- Smooth scrolling
    -----------------------------------------------------------------------------
    -- {
    --   "karb94/neoscroll.nvim",
    --   event = "VeryLazy",
    --   config = function ()
    --     require('neoscroll').setup {}
    --   end
    -- },

    -----------------------------------------------------------------------------
    --- Show vertical indent lines
    -----------------------------------------------------------------------------
    -- {
    --     "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}
    -- },

    -----------------------------------------------------------------------------
    --- Bottom-right text notifications
    -----------------------------------------------------------------------------
    {
        "j-hui/fidget.nvim",
        opts = {},
    },

    -----------------------------------------------------------------------------
    --- Smooth scrolling
    -----------------------------------------------------------------------------
    {
        'declancm/cinnamon.nvim',
        opts = {
            keymaps = {
                basic = true,
                extra = true,
            }
        },
    },

    -----------------------------------------------------------------------------
    --- UI hooks for vim.ui.select and vim.ui.input
    -----------------------------------------------------------------------------
    -- {
    --     'stevearc/dressing.nvim',
    --     event = "VeryLazy"
    -- },

    -----------------------------------------------------------------------------
    --- Status line
    -----------------------------------------------------------------------------
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        opts = {
            options = {
                theme                = "custom",
                component_separators = { left = " ", right = " " },
                section_separators   = { left = " ", right = " " },
                globalstatus         = true,
                disabled_filetypes   = { statusline = { "dashboard", "alpha" } }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { { 'filename', path = 1 } },
                lualine_c = {},
                lualine_x = {},
                lualine_y = { 'branch', 'filetype' },
                lualine_z = { 'location', "progress" },
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    },
}
