-- See `:help vim.keymap.set()` or one of the following:
-- :nmap
-- :vmap
-- :imap

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)

vim.keymap.set('n', '<leader>.', ':cd %:p:h<CR>',  { desc = 'set current working directory' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)          -- move selected (v mode) down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)          -- move selected (v mode) up

vim.keymap.set({'n', 'o', 'x'}, '<s-h>', '^', opts)         -- move to end of line
vim.keymap.set({'n', 'o', 'x'}, '<s-l>', 'g_', opts)        -- move to start of line

-- vim.keymap.set("n", "<leader>sf", "<cmd>FZF<CR>", { desc = "[S]earch [F]uzzy"})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', "<leader>R", "<cmd>.lua<CR>", { desc = "[R]un the current line" })

-- search
vim.keymap.set('n', 'n', 'nzz', opts)
vim.keymap.set('n', 'N', 'Nzz', opts)
vim.keymap.set('n', '*', '*zz', opts)

-- stay in indent mode (todo: use <Tab> and <s>-<Tab> if possible)
vim.keymap.set('v', '<s-TAB>', '<gv', opts)
vim.keymap.set('v', '<TAB>', '>gv', opts)

vim.keymap.set('i', '<s-TAB>', '<C-d>', opts)

-- when yanking a word, you can replace word under cursor [vep]
vim.keymap.set('x', 'p', [["_dP]])

-- diagnostic 
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

