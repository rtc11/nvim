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
vim.opt.rtp:prepend("/opt/homebrew/bin/fzf")

-- temporary fix to support the new treesitter in telescope
if vim.treesitter.language.ft_to_lang == nil then
  vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
end

require("options")
-- require("lazy").setup("plugins")
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = {
    notify = false, -- notify when changes are found
  },
})
require("keymaps")

vim.cmd.colorscheme "ashen"

vim.filetype.add({
  extension = {
    ty = "ty",
    cbl = "cobol",
    js = "js",
    ts = "js",
    tsx = "js",
  }
})

vim.lsp.enable("kotlin_lsp")
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
