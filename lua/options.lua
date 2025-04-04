vim.g.mapleader = ' '                               -- use <space> as leader key
vim.g.maplocalleader = ' '                          -- use <space> as local leader key

vim.wo.number = true                                -- Make line numbers default
vim.wo.relativenumber = true                        -- show relative numbers
vim.wo.signcolumn = 'yes'                           -- Keep signcolumn on by default
vim.wo.wrap = false                                 -- Don't wrap lines

vim.opt.autoindent = true                           -- automatically set the indent of a new line
vim.opt.backspace = { "indent", "eol", "start" }    -- specifies what <backspace>, <ctrl w> etc can do in INSERT mode
vim.opt.breakindent = true                          -- Enable break indent
vim.opt.clipboard = 'unnamedplus'                   -- Sync clipboard between OS and Neovim. :help clipboard
vim.opt.cmdheight = 1                               -- More space for displaying messages
vim.opt.completeopt = 'menu,menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.cursorcolumn = false                        -- Enable highlighting of the current colum
vim.opt.cursorline = true                           -- Enable highlighting of the current line
vim.opt.expandtab = true                            -- expand <tab> to spaces in INSERT mode
vim.opt.fileencoding = "utf-8"                      -- The encoding written to file
-- vim.opt.formatoptions = "jcroqlnt"                  -- tcqj
vim.opt.formatoptions:remove "o"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.shada = { "'10", "<0", "s10", "h" }         -- save buffers, marks, registers, etc between sessions per project
vim.opt.swapfile = false                            -- temp save buffers
vim.opt.guicursor = ""                              -- "a:blinkon0"
vim.opt.guifont = "monospace:h17"
vim.opt.hlsearch = true                             -- set highlight on search
vim.opt.ignorecase = true                           -- Case insensitive searching UNLESS /C or capital in search
vim.opt.inccommand = "split"                        -- Incremental live completion
vim.opt.mouse = 'a'                                 -- Enable mouse mode
vim.opt.scrolloff = 8                               -- Lines of context
vim.opt.shiftwidth = 4                              -- number of spaces to use for each step of (auto)indent
vim.opt.showcmd = false                             -- Don't show extra info when using completion
vim.opt.showtabline = 1                             -- Tabline
vim.opt.sidescrolloff = 8                           -- Columns of context
vim.opt.smartcase = true
vim.opt.smartindent = true                          -- do clever autoindent
vim.opt.splitbelow = true                           -- Horizontal splits will automatically be below
vim.opt.splitright = true                           -- Vertical splits will automatically be to the right
vim.opt.tabstop = 4                                 -- number of spaces that a <tab> in the file counts for 
vim.opt.termguicolors = true                        -- You should make sure your terminal supports this
vim.opt.timeout = true
vim.opt.timeoutlen = 1000                           -- time to wait for a mapped sequence to complete (ms)
vim.opt.title = true                                -- Set the title of window to the value of the titlestring
vim.opt.undofile = true                             -- Save undo history
vim.opt.updatetime = 200                            -- faster completion (ms)
vim.opt.wildmode = "longest:full,full"              -- command-line completion mode

