-- See `:help vim.keymap.set()` or one of the following:
-- :Telescope keymaps
-- :nmap
-- :vmap
-- :imap

--
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- movement
--keymap('n', '<C-d>', '<C-d>zz', opts)               -- move cursor centered when scrolling
--keymap('n', '<C-u>', '<C-u>zz', opts)               -- move cursor centered when scrolling

keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)          -- move selected (v mode) down
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)          -- move selected (v mode) up

keymap({'n', 'o', 'x'}, '<s-h>', '^', opts)         -- move to end of line
keymap({'n', 'o', 'x'}, '<s-l>', 'g_', opts)        -- move to start of line

-- tabs
keymap('n', '<C-t>q', ':tabclose<CR>', { desc = 'Close tab' })
keymap('n', '<C-c>o', ':tabonly<CR>', { desc = 'Close other tabs' })
keymap('n', '<C-t>s', ':tab sball<CR>', { desc = 'Open all buffers in tabs' })
keymap('n', '<C-t>h', ':tabprev<CR>', { desc = 'Previous tab' })
keymap('n', '<C-t>l', ':tabnext<CR>', { desc = 'Next tab' })

keymap('n', '<C-b>h', ':bnext<CR>', { desc = "Next buffer"})
keymap('n', '<C-b>l', ':bprevious<CR>', { desc = "Previous buffer"})

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- search
keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)
keymap('n', '*', '*zz', opts)
keymap('n', '#', '#zz', opts)
keymap('n', 'g*', 'g*zz', opts)
keymap('n', 'g#', 'g#zz', opts)

-- stay in indent mode (todo: use <Tab> and <s>-<Tab> if possible)
keymap('v', '<s-TAB>', '<gv', opts)
keymap('v', '<TAB>', '>gv', opts)

keymap('i', '<s-TAB>', '<C-d>', opts)

-- when yanking a word, you can replace word under cursor [vep]
keymap('x', 'p', [["_dP]])


keymap("n", "<leader>gg", ":Neogit<CR>", { desc = "Open Neogit" })
keymap('n', '-', '<CMD>Oil<CR>', { desc = "Open parent directory" })

-- diagnostic 
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

