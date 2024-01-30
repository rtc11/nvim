-- See `:help vim.keymap.set()`

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

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

keymap({'n', 'o', 'x'}, '<s-h>', '^', opts)
keymap({'n', 'o', 'x'}, '<s-l>', 'g_', opts)

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

