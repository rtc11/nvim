return {

    ---------------------------------------------------------------------------
    -- Handy functions like async, job, path, strings, filetypes, etc
    -----------------------------------------------------------------------------
    { 'nvim-lua/plenary.nvim' },

    ---------------------------------------------------------------------------
    -- Run something async. 1. Open quickfix window with :copen 2. Run :AsyncRun <cmd>
    -----------------------------------------------------------------------------
    -- { 'skywind3000/asyncrun.vim' },

    ---------------------------------------------------------------------------
    -- Find available key mapping
    -----------------------------------------------------------------------------
    -- { 'meznaric/key-analyzer.nvim', opts = {} },

    ---------------------------------------------------------------------------
    -- Easy align text. E.g. ga=, ga:, ga
    -----------------------------------------------------------------------------
    {
        'junegunn/vim-easy-align',
        config = function()
            vim.keymap.set('x', 'ga', ':EasyAlign', { noremap = false })
        end
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
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {}
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
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            }
        }
    }

}
