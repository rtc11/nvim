return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    --'folke/zen-mode.nvim',
    --{ 'ThePrimeagen/harpoon', branch = 'harpoon2' },
  },
  config = function()
    --vim.keymap.set('n', '<C-n>', ':Neotree filesystem float<CR>')
    vim.keymap.set('n', '<C-n>', ':Neotree toggle left<CR>')

    --[[
    --
    require('neo-tree').setup {
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
      commands = {
        harpoon_clear = function()
          require('harpoon'):list():clear()
        end,

        harpoon_append = function(state)
          local node = state.tree:get_node()
          local path = vim.fn.fnamemodify(node.path, ':~:.')
          require('harpoon'):list():append({ value = path })
        end,

        harpoon_prepend = function(state)
          local node = state.tree:get_node()
          local path = vim.fn.fnamemodify(node.path, ':~:.')
          require('harpoon'):list():prepend({ value = path })
        end,
      },

      filesystem = {
        --filtered_items = { visible = true },
        --follow_current_file = { enable = false },
        --bind_to_cwd = false,
        --hijack_netrw_behavior = "disabled",
        window = {
          mappings = {
            ["<C-c>"] = "harpoon_clear",
            ["<C-a>"] = "harpoon_append",
            ["<C-p>"] = "harpoon_prepend",
          }
        },

        components = {
          harpoon = function(config, node, _)
            local function is_harpooned(idx)
              local items = require('harpoon'):list()
              local item = items:get(idx)
              return item and item.value:gsub(".*/", "") == node:get_id():gsub(".*/", "")
            end

            if is_harpooned(1) then
              return {
                text = ' <C-h>',
                highlight = config.highlight or 'NeoTreeDirectoryIcon',
              }
            elseif is_harpooned(2) then
              return {
                text = ' <C-j>',
                highlight = config.highlight or 'NeoTreeDirectoryIcon',
              }
            elseif is_harpooned(3) then
              return {
                text = ' <C-k>',
                highlight = config.highlight or 'NeoTreeDirectoryIcon',
              }
            elseif is_harpooned(4) then
              return {
                text = ' <C-l>',
                highlight = config.highlight or 'NeoTreeDirectoryIcon',
              }
            end
          end
        },

        renderers = {
          file = {
            { 'icon' },
            { 'name',       use_git_status_colors = true },
            { 'harpoon' },
            { 'diagnostics' },
            { 'git_status', highlight = 'NeoTreeDimText' },
          }
        },
      }
    }
    --]]
  end
}
