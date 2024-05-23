return {
  "folke/zen-mode.nvim",
  opts = {},
  config = function()
    require("zen-mode").setup({
      window = {
        backdrop = 0.95,
        --width = 0.85,
        --height = 0.85,
        --[[
        options = {
          signcolumn = "no",
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
        --]]
      },
    })

    -- Keybindings
    -- Toggle Zen mode
    vim.keymap.set("n", "<leader>Z", ":ZenMode<CR>", { noremap = true, silent = true, desc = "Toggle Zen mode"})
  end
}
