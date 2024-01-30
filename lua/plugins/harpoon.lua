return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({})

        local toggle = function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end

        vim.keymap.set('n', '<leader>hl', toggle, { desc = "[H]arpoon [L]ist" })
        --vim.keymap.set('n', '<C-a>', require('harpoon.mark').add_file())
        vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end)
        vim.keymap.set('n', '<C-j>', function() harpoon:list():select(2) end)
        vim.keymap.set('n', '<C-k>', function() harpoon:list():select(3) end)
        vim.keymap.set('n', '<C-l>', function() harpoon:list():select(4) end)
    end
}
