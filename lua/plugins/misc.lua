return {
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
    },

    -- Handy functions like async, job, path, strings, filetypes, etc
    { 'nvim-lua/plenary.nvim' },

    -- Run something async. 1. Open quickfix window with :copen 2. Run :AsyncRun <cmd>
    {
        'skywind3000/asyncrun.vim',
    },

    {
        'junegunn/vim-easy-align',
        config = function()
            vim.keymap.set('x', 'ga', ':EasyAlign', { noremap = false })
        end
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    -- Highlight, list, search, and edit TODOs in your projects
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {}
    },

    {
        'mbbill/undotree',
        keys = {
            { "<leader>u", ":UndotreeToggle<CR>", desc = "Toggle undotree" },
        },
    },

}
