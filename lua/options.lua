-- use <space> as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.wo.number = true         -- Make line numbers default
vim.wo.relativenumber = true -- show relative numbers
vim.wo.signcolumn = 'yes'    -- Keep signcolumn on by default
vim.wo.wrap = false          -- Don't wrap lines

vim.opt.expandtab = true     -- expand <tab> to spaces in INSERT mode
vim.opt.autoindent = true    -- automatically set the indent of a new line
vim.opt.smartindent = true   -- do clever autoindent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.backspace = { "indent", "eol", "start" } -- specifies what <backspace>, <ctrl w> etc can do in INSERT mode
vim.opt.hlsearch = false                         -- set highlight on search
vim.opt.mouse = 'a'                              -- Enable mouse mode
vim.opt.clipboard = 'unnamedplus'                -- -- Sync clipboard between OS and Neovim. :help clipboard
vim.opt.breakindent = true                       -- Enable break indent
vim.opt.undofile = true                          -- Save undo history
vim.opt.ignorecase = true                        -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.updatetime = 250                         -- Decrease update time
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true             -- NOTE: You should make sure your terminal supports this
