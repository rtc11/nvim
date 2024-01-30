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

require("options")
require("lazy").setup("plugins")
require("keymaps")

-- Get opam share path for configuring merlin
local opam_share = vim.fn.system { 'opam',  'var',  'share', }
--local opam_bin = vim.fn.system { 'opam', 'var', 'bin' }
--vim.fn.execute(':helptags ' .. opam_share .. '/merlin/vim/doc', false)

vim.opt.rtp:prepend(opam_share .. '/merlin/vim')
--vim.opt.rtp:prepend(opam_share .. '/ocp-indent/vim')
--vim.opt.rtp:prepend(opam_bin)
--vim.cmd(["'helptags ' .. opam_share_path .. '/merlin/vim/doc'"])

-- See :help vim.highlight.on_yank()
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--[[
vim.api.nvim_create_autocmd( { "BufRead", "BufNewFile"}, {
  pattern = "*.mli",
  desc = "Detect and set the proper file type for ocaml interface files",
  callback = function()
    vim.cmd(":set filetype=ocamlinterface")
  end,
})
--]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
