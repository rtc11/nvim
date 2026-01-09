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
require("lazy").setup("plugins")
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cobol",
  callback = function()
    vim.b.cobol_format_free = 1
  end,
  desc = "Enable Free Format COBOL Syntax",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c3",
  callback = function()
    vim.opt_local.errorformat = "%E(%f:%l:%c) Error: %m,%Z%.%#,%C%.%#"
    vim.opt_local.makeprg = "c3c build"
  end,
  desc = "Set error format and makeprg for c3"
})

-- makeprg for kotlin
vim.api.nvim_create_autocmd("FileType", {
  pattern = "kotlin",
  callback = function()
    -- gradle error format
    local kotlin_patterns = {
      [[%t: file://%f:%l:%c %m]], -- match e: file://path/file.kt:34:24 message
    }
    vim.opt_local.errorformat = table.concat(kotlin_patterns, ',') 

    -- set makeprg=
    local cwd = vim.fn.expand("%:p:h")
    if vim.fn.filereadable(cwd .. "/build.gradle.kts") then
      vim.opt_local.makeprg = "./gradlew build"
    -- elseif vim.fn.executable(cwd .. "/nob") == 1 then
      -- vim.opt_local.makeprg  = "./nob"
    -- else
      -- vim.opt_local.makeprg = "./gradlew build"
    end
  end
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
