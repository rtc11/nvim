return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function ()
    require('which-key').register({
      ['<leader>'] = { name = 'VISUAL <leader>' },
      ['<leader>h'] = { name = 'Git [h]unk'},
    }, { mode = 'v' })
  end
}
