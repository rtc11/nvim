return {

    ---------------------------------------------------------------------------
    -- Show git blame
    -----------------------------------------------------------------------------
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function()
            require('blame').setup {}
        end,
        opts = {
            blame_options = { '-w' }
        },
        keys = {
            { '<Leader>gb', ':BlameToggle<CR>', mode = 'n', desc = 'Neogit' },
        }
    },
    ---------------------------------------------------------------------------
    -- Show marks in the sign column
    -----------------------------------------------------------------------------
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {
            default_mappings = false,
        },
    },
    ---------------------------------------------------------------------------
    -- Highlight rgb/hsl colors
    -----------------------------------------------------------------------------
    {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup({})
        end
    },
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

    ---------------------------------------------------------------------------
    -- Show marks, jumps, and buffers
    -----------------------------------------------------------------------------
    -- {
    --     "gcmt/vessel.nvim",
    --     config = function()
    --         require("vessel").setup({
    --             create_commands = true,
    --         })
    --     end,
    --     keys = {
    --         {
    --             "<leader><space>",
    --             ":Jumps<cr>",
    --             desc = "Show jumps"
    --         },
    --     }
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
    -- {
    --     'declancm/cinnamon.nvim',
    --     opts = {
    --         keymaps = {
    --             basic = true,
    --             extra = true,
    --         }
    --     },
    -- },

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
