vim.bo.commentstring = "//%s"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c3",
  callback = function()
    vim.opt_local.errorformat = "%E(%f:%l:%c) Error: %m,%Z%.%#,%C%.%#"
    vim.opt_local.makeprg = "c3c build"
  end,
  desc = "Set error format and makeprg for c3"
})

