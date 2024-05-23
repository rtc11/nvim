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
    },
    -- Tabpage interface for cycling through diffs
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
        keys = {
            { '<Leader>gd', ':DiffviewFileHistory %<CR>', desc = 'Diff File' },
            { '<Leader>gv', ':DiffviewOpen<CR>',          desc = 'Diff View' },
        },
        opts = function()
            local actions = require('diffview.actions')
            vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
                group = vim.api.nvim_create_augroup('rafi_diffview', {}),
                pattern = 'diffview:///panels/*',
                callback = function()
                    vim.opt_local.cursorline = true
                    vim.opt_local.winhighlight = 'CursorLine:WildMenu'
                end,
            })

            return {
                enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
                keymaps = {
                    view = {
                        { 'n', 'q',              actions.close },
                        { 'n', '<Tab>',          actions.select_next_entry },
                        { 'n', '<S-Tab>',        actions.select_prev_entry },
                        { 'n', '<LocalLeader>a', actions.focus_files },
                        { 'n', '<LocalLeader>e', actions.toggle_files },
                    },
                    file_panel = {
                        { 'n', 'q',              actions.close },
                        { 'n', 'h',              actions.prev_entry },
                        { 'n', 'o',              actions.focus_entry },
                        { 'n', 'gf',             actions.goto_file },
                        { 'n', 'sg',             actions.goto_file_split },
                        { 'n', 'st',             actions.goto_file_tab },
                        { 'n', '<C-r>',          actions.refresh_files },
                        { 'n', '<LocalLeader>e', actions.toggle_files },
                    },
                    file_history_panel = {
                        { 'n', 'q', '<cmd>DiffviewClose<CR>' },
                        { 'n', 'o', actions.focus_entry },
                        { 'n', 'O', actions.options },
                    },
                },
            }
        end,
    },

}
