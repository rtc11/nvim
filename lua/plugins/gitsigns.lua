return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
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
        map('v', '<leader>gS', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[g]it [S]tage hunk' })
        map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[g]it [r]eset hunk' })

        -- normal mode
        map('n', '<leader>gs', gs.stage_hunk, { desc = '[g]it [s]tage hunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = '[g]it [r]eset hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = '[g]it [S]tage buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[g]it [u]ndo stage hunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = '[g]it [R]eset buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = '(g)it [p]review hunk' })
        map('n', '<leader>gb', function() gs.blame_line { full = false } end, { desc = '[g]it [b]lame line' })
        map('n', '<leader>gd', gs.diffthis, { desc = '[g]it [d]iff against index' })
        map('n', '<leader>gD', function() gs.diffthis '~' end, { desc = '[g]it [D]iff against last commit' })

        -- Toggles
        map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = '[g]it toggle git [B]lame line' })
        map('n', '<leader>gD', gs.toggle_deleted, { desc = '[g]it toggle show [D]eleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  }
