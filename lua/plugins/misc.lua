return {
    ---------------------------------------------------------------------------
    -- Handy functions like async, job, path, strings, filetypes, etc
    -----------------------------------------------------------------------------
    {
        "nvim-lua/plenary.nvim"
    },
    ---------------------------------------------------------------------------
    -- Easy align text. E.g. VISUAL ga=, ga:, ga*,
    -----------------------------------------------------------------------------
    {
        'nvim-mini/mini.align',
        version = '*',
        opts = {}
    },
    ---------------------------------------------------------------------------
    -- auto pair brackets, quotes, etc
    -----------------------------------------------------------------------------
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    ---------------------------------------------------------------------------
    -- Highlight TODOs, FIXMEs, etc 
    -----------------------------------------------------------------------------
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                TODO = { icon = " ", color = "#4A8B8B" },
            },
        },
        keys = {
            {
                "<leader>tt", ":TodoFzfLua<CR>", desc = "Todo fzf",
            }
        }
    },
    ---------------------------------------------------------------------------
    -- Which key
    -----------------------------------------------------------------------------
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)",
            }
        }
    }

}
