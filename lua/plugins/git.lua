return {
    "neogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = true,
}


--[[
return {
    -- git blame, git diff, mergetools, etc.
    {
        'tpope/vim-rhubarb',
    },
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    {
        'lewis6991/gitsigns.nvim',
        opts = {
          -- See `:help gitsigns.txt`
          signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
          },
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map({ 'n', 'v' }, ']c', function()
              if vim.wo.diff then
                return ']c'
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return '<Ignore>'
            end, { expr = true, desc = 'Jump to next hunk' })

            map({ 'n', 'v' }, '[c', function()
              if vim.wo.diff then
                return '[c'
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return '<Ignore>'
            end, { expr = true, desc = 'Jump to previous hunk' })

            -- Actions
            -- visual mode
            map('v', '<leader>GS', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[g]it [S]tage hunk' })
            map('v', '<leader>Gr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[g]it [r]eset hunk' })

            -- normal mode
            map('n', '<leader>Gs', gs.stage_hunk, { desc = '[G]it [s]tage hunk' })
            map('n', '<leader>Gr', gs.reset_hunk, { desc = '[G]it [r]eset hunk' }) -- key used in gradle
            map('n', '<leader>GS', gs.stage_buffer, { desc = '[G]it [S]tage buffer' })
            map('n', '<leader>Gu', gs.undo_stage_hunk, { desc = '[G]it [u]ndo stage hunk' })
            map('n', '<leader>GR', gs.reset_buffer, { desc = '[G]it [R]eset buffer' })
            map('n', '<leader>Gp', gs.preview_hunk, { desc = '(G)it [p]review hunk' })
            map('n', '<leader>Gb', function() gs.blame_line { full = false } end, { desc = '[G]it [b]lame line' })
            map('n', '<leader>Gd', gs.diffthis, { desc = '[G]it [d]iff against index' })
            map('n', '<leader>GD', function() gs.diffthis '~' end, { desc = '[G]it [D]iff against last commit' })

            -- Toggles
            map('n', '<leader>GB', gs.toggle_current_line_blame, { desc = '[G]it toggle git [B]lame line' })
            map('n', '<leader>GD', gs.toggle_deleted, { desc = '[G]it toggle show [D]eleted' })

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
          end,
        },
      }
}
--]]
