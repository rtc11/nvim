vim.bo.commentstring = "*> %s"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cobol",
  callback = function()
    vim.b.cobol_format_free = 1
  end,
  desc = "Enable Free Format COBOL Syntax",
})
