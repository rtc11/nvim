-- makeprg for kotlin
vim.api.nvim_create_autocmd("FileType", {
  pattern = "kotlin",
  callback = function()
    -- gradle error format
    local kotlin_patterns = {
      [[%t: file://%f:%l:%c %m]], -- match e: file://path/file.kt:34:24 message
    }
    vim.opt_local.errorformat = table.concat(kotlin_patterns, ',') 

    -- set makeprg=
    local cwd = vim.fn.expand("%:p:h")
    if vim.fn.filereadable(cwd .. "/build.gradle.kts") then
      vim.opt_local.makeprg = "./gradlew build"
    -- elseif vim.fn.executable(cwd .. "/nob") == 1 then
      -- vim.opt_local.makeprg  = "./nob"
    -- else
      -- vim.opt_local.makeprg = "./gradlew build"
    end
  end
})

