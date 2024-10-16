vim.g.mapleader = ' '                            -- use <space> as leader key
vim.g.maplocalleader = ' '                       -- use <space> as local leader key

vim.wo.number = true                             -- Make line numbers default
vim.wo.relativenumber = true                     -- show relative numbers
vim.wo.signcolumn = 'yes'                        -- Keep signcolumn on by default
vim.wo.wrap = false                              -- Don't wrap lines

vim.opt.inccommand = "split"                     -- Incremental live completion
vim.opt.splitbelow = true                        -- Horizontal splits will automatically be below
vim.opt.splitright = true                        -- Vertical splits will automatically be to the right

vim.opt.expandtab = true                         -- expand <tab> to spaces in INSERT mode
vim.opt.autoindent = true                        -- automatically set the indent of a new line
vim.opt.smartindent = true                       -- do clever autoindent
vim.opt.tabstop = 4                              -- number of spaces that a <tab> in the file counts for 
vim.opt.shiftwidth = 4                           -- number of spaces to use for each step of (auto)indent
vim.opt.backspace = { "indent", "eol", "start" } -- specifies what <backspace>, <ctrl w> etc can do in INSERT mode
vim.opt.hlsearch = true                          -- set highlight on search
vim.opt.mouse = 'a'                              -- Enable mouse mode
vim.opt.clipboard = 'unnamedplus'                -- Sync clipboard between OS and Neovim. :help clipboard
vim.opt.breakindent = true                       -- Enable break indent
vim.opt.undofile = true                          -- Save undo history
vim.opt.ignorecase = true                        -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.updatetime = 100                         -- faster completion (ms)
vim.opt.timeout = true
vim.opt.timeoutlen = 1000                        -- time to wait for a mapped sequence to complete (ms)
vim.opt.completeopt = 'menuone,noselect'         -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true                     -- You should make sure your terminal supports this
vim.opt.guicursor = ""                           -- "a:blinkon0"
vim.opt.showtabline = 1                          -- Tabline
vim.opt.title = true                             -- Set the title of window to the value of the titlestring
vim.opt.scrolloff = 8                            -- Lines of context
vim.opt.sidescrolloff = 8                        -- Columns of context
vim.opt.guifont = "monospace:h17"
vim.opt.cursorline = true                        -- Enable highlighting of the current line
vim.opt.fileencoding = "utf-8"                   -- The encoding written to file
vim.opt.cmdheight = 1                            -- More space for displaying messages
vim.opt.showcmd = false                          -- Don't show extra info when using completion

vim.opt.formatoptions = {
    c = true, -- auto-wrap comments using textwidth  
    o = false, -- don't continue comments
    O = false, -- don't continue comments
    r = false, -- auto insert the comment leader after hitting <enter> in insert mode
    j = true -- remove comment leader when joining lines
}

