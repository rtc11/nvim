return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
        })

        -- vim.api.nvim_create_augroup('remember_folds', { clear = true })

        --[[ save and load foalds
        vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
            pattern = { '*.*' },
            desc = 'save view (folds), when closing file',
            command = 'mkview',
        })

        vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
            pattern = { '*.*' },
            desc = 'load view (folds), when opening file',
            command = 'silent! loadview',
        })
        -- ]]
    end
}
