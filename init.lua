local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)
vim.opt.rtp:prepend("/opt/homebrew/bin/fzf")

require("options")
-- require("lazy").setup("plugins")
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = {
    notify = false, -- notify when changes are found
  },
  rocks = {
    enabled = false,
  },
})
require("keymaps")

vim.cmd.colorscheme "ashen"

vim.filetype.add({
  extension = {
    ty = "ty",
    cbl = "cobol",
  }
})

vim.lsp.enable("kotlin_lsp")
-- vim.lsp.enable("kls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("c3lsp")
-- vim.lsp.enable("cobol")

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
