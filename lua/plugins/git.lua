return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = 'Neogit',
        keys = {
            { '<leader>gg', ':Neogit<CR>', desc = 'Open Neogit' },
        },
        opts = {
            disable = false,
            disable_context_highlighting = false,
            disable_commit_confirmation = false,
            integrations = {
                diffview = true,
            }
        },
    },
    {
        'FabijanZulj/blame.nvim',
        cmd = 'ToggleBlame',
        -- stylua: ignore
        keys = {
            { '<leader>gb', ':BlameToggle virtual<CR>', desc = 'Git blame' },
            { '<leader>gB', ':BlameToggle window<CR>',  desc = 'Git blame (window)' },
        },
        opts = {
            date_format = '%Y-%m-%d %H:%M',
            merge_consecutive = false,
            max_summary_width = 30,
            mappings = {
                commit_info = 'K',
                stack_push = '>',
                stack_pop = '<',
                show_commit = '<CR>',
                close = { '<Esc>', 'q' },
            },
        },
    }
}
