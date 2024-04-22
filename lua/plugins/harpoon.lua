return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon [A]dd" })
        vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon [L]ist" })

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon select [1]" })
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { desc = "Harpoon select [2]" })
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { desc = "Harpoon select [3]" })
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Harpoon select [4]" })

        -- Toggle previous & next buffers stored within Harpoon list
        --vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        --vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end
}
