return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup {
      icons = false,
    }

    local trouble = require('trouble')

    vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end, { desc = "trouble toggle"} )
    vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end, { desc = "trouble [w]orkspace diagnostics"} )
    vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end, { desc = "trouble [d]oument diagnostics"} )
    vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end, { desc = "trouble [q]uickfix"} )
    vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end, { desc = "trouble [l]oclist"} )
    vim.keymap.set("n", "<leader>xn", function() trouble.next({skip_groups = true, jump=true}) end, { desc = "trouble [n]ext"} )
    vim.keymap.set("n", "<leader>xp", function() trouble.previous({skip_groups = true, jump=true}) end, { desc = "trouble [p]revious"} )
    vim.keymap.set("n", "gR", function() trouble.toggle("lsp_references") end, { desc = "trouble [R]eference (LSP)"} )
--    vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", { noremap = true, silent = true })
  end
}
