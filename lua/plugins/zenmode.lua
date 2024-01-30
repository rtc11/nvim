return {
  'folke/zen-mode.nvim',
  opts = {},
  config = function ()
    local zen = require('zen-mode')


    vim.keymap.set( 'n', '<leader>zZ', zen.toggle, {desc ='ZenMode' })
  end
}
