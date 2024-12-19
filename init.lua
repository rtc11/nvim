local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
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
vim.opt.rtp:prepend("/usr/local/bin/fzf")

require("options")
require("lazy").setup("plugins")
require("keymaps")

vim.cmd.colorscheme "monocle"
-- vim.cmd.colorscheme "rtc11"

vim.filetype.add({
  extension = {
    mill = "scala",
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  }
})

-- See :help vim.highlight.on_yank()
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
