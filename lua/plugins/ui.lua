return {
    -----------------------------------------------------------------------------
    -- Improve quickfix ui/workflow
    -----------------------------------------------------------------------------
    {
      "stevearc/quicker.nvim",
      event = "FileType qf",
      opts = {},
      keys = {
        { "<leader>l", function() require("quicker").toggle() end, desc = "Show buffers" },
      },
    },
    ---------------------------------------------------------------------------
    -- Enable ansicolors in e.g. quickfix list
    -----------------------------------------------------------------------------
    {
      '0xferrous/ansi.nvim',
      config = function()
        require('ansi').setup({
          auto_enable = true,
          filetypes = { 'qf' },
          theme = 'gruvbox'
        })
      end
    },
    ---------------------------------------------------------------------------
    -- Diagnostics
    -----------------------------------------------------------------------------
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                          desc = "Diagnostics (Trouble)"        },
        { "<leader>xn", "<cmd>Trouble diagnostics next skip_groups=true jump=true<cr>", desc = "Next (Trouble)"               },
        { "<leader>xp", "<cmd>Trouble diagnostics prev skip_groups=true jump=true<cr>", desc = "Previous (Trouble)"           },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                               desc = "Quickfix List (Trouble)"      },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",             desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                  desc = "Symbols (Trouble)"            },
        { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",   desc = "LSP Defs / refs (Trouble)"    },
        { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                              desc = "Location List (Trouble)"      },
    },
    ---------------------------------------------------------------------------
    -- Show git blame
    -----------------------------------------------------------------------------
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function()
            require("blame").setup {}
        end,
        opts = {
            blame_options = { "-w" }
        },
        keys = {
            { "<Leader>gb", ":BlameToggle<CR>", mode = "n", desc = "Neogit" },
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
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end
    },
    ---------------------------------------------------------------------------
    -- File browser
    -----------------------------------------------------------------------------
    {
        "stevearc/oil.nvim",
        opts = {
            columns = { "icon" },
            view_options = {
                show_hidden = true,
            }
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "-", ":Oil<CR>", desc = "Open Oil" },
        },
    },
    -----------------------------------------------------------------------------
    --- Bottom-right text notifications
    -----------------------------------------------------------------------------
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
    -----------------------------------------------------------------------------
    --- Status line
    -----------------------------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            -- "ficcdaf/ashen.nvim",
        },
        event = "VeryLazy",
        opts = {
            options = {
                -- theme                = require("ashen.plugins.lualine").theme,
                -- theme                = "custom",
                theme                = "auto",
                component_separators = { left = " ", right = " " },
                section_separators   = { left = " ", right = " " },
                globalstatus         = true,
                disabled_filetypes   = { statusline = { "dashboard", "alpha" } }
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { { "filename", path = 1 } },
                lualine_c = { },
                lualine_x = {},
                lualine_y = { "branch", "filetype" },
                lualine_z = { "location", "progress" },
            },
            inactive_sections = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
}

