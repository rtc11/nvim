return {
    'stevearc/oil.nvim',
    opts = {
        columes = { "icon" },
        view_options = {
            show_hidden = true,
        }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { '-', ':Oil<CR>', desc = 'Open Oil' },
    },
}
