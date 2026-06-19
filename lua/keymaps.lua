-- See `:help vim.keymap.set()` or one of the following:
-- :nmap
-- :vmap
-- :imap

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)

vim.keymap.set('n', '<leader>.', ':cd %:p:h<CR>',  { desc = 'set current working directory' })
vim.keymap.set('n', '<leader><CR>', '<Cmd>update<CR><Cmd>make<CR>', { desc = 'update and make' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)          -- move selected (v mode) down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)          -- move selected (v mode) up

vim.keymap.set({'n', 'o', 'x'}, '<s-h>', '^', opts)         -- move to end of line
vim.keymap.set({'n', 'o', 'x'}, '<s-l>', 'g_', opts)        -- move to start of line

vim.keymap.set('n', 'gt', function() local word = vim.fn.expand("<cword>") if word ~= '' then vim.cmd('tag ' .. word) end end, { desc = 'go to tag' })

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
-- vim.keymap.set('i', '<TAB>', '<C-t>', opts)

-- when yanking a word, you can replace word under cursor [vep]
vim.keymap.set('x', 'p', [["_dP]])

-- diagnostic 
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- LSP
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code actions" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "goto definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "goto references" })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "goto implementation" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "goto declaration" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "signature documentation" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "rename symbol" })
vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "document symbols" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "goto type definition" })
vim.keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, { desc = "Incoming calls" })
vim.keymap.set("n", "<leader>co", vim.lsp.buf.outgoing_calls, { desc = "Outgoing calls" })
vim.keymap.set('n', '<leader>tH', function() vim.lsp.buf.typehierarchy("supertypes") end)
vim.keymap.set('n', '<leader>th', function() vim.lsp.buf.typehierarchy("subtypes") end)
vim.keymap.set("v", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "LSP format selection" })
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run code lens" })
