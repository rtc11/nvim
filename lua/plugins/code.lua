return {

    -----------------------------------------------------------------------------
    -- Powerful line and block-wise commenting
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        keys = {
            { '<Leader>v', '<Plug>(comment_toggle_linewise_current)',  mode = 'n', desc = 'Comment line' },
            { '<Leader>v', '<Plug>(comment_toggle_linewise_visual)',   mode = 'x', desc = 'Comment line' },
            { '<Leader>V', '<Plug>(comment_toggle_blockwise_current)', mode = 'n', desc = 'Comment block' },
            { '<Leader>V', '<Plug>(comment_toggle_blockwise_visual)',  mode = 'x', desc = 'Comment block' },
        },
        opts = function(_, opts)
            local ok, tcc = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
            if ok then
                opts.pre_hook = tcc.create_pre_hook()
            end
        end,
    },

    -----------------------------------------------------------------------------
    -- Perform diffs on blocks of code
    {
        'AndrewRadev/linediff.vim',
        cmd = { 'Linediff', 'LinediffAdd' },
        keys = {
            { '<Leader>mdf', ':Linediff<CR>',          mode = 'x',              desc = 'Line diff' },
            { '<Leader>mda', ':LinediffAdd<CR>',       mode = 'x',              desc = 'Line diff add' },
            { '<Leader>mds', '<cmd>LinediffShow<CR>',  desc = 'Line diff show' },
            { '<Leader>mdr', '<cmd>LinediffReset<CR>', desc = 'Line diff reset' },
        },
    },

    -----------------------------------------------------------------------------
    -- Leap through the code with s (forward seeking) or S (backward seeking)
    {
        'ggandor/leap.nvim',
        dependencies = { 'tpope/vim-repeat' },
        config = function()
            require('leap').add_default_mappings()
        end
    },
    {
        'github/copilot.vim',
        event = "VeryLazy",
    },
    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
    }
}
