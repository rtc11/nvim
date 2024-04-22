return {
    "rmehri01/onenord.nvim",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "onenord"
    end,
}
--[[
return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function ()
    vim.cmd.colorscheme "catppuccin"
  end
}
--]]
--[[
return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'onedark'
  end,
}
return {
  'AlexvZyl/nordic.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('nordic').load()
    -- or 
    -- vim.cmd.colorscheme 'nordic'
  end
}
--]]

