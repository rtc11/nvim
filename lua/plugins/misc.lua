return {
    -- Handy functions like async, job, path, strings, filetypes, etc
    {
        'nvim-lua/plenary.nvim',
    },
    -- neovim development utilities
    {
        "folke/neodev.nvim",
        opts = {}
    },

    {
        'junegunn/vim-easy-align',
        config = function()
            vim.keymap.set('x', 'ga', ':EasyAlign', { noremap = false })
        end
    }
}
