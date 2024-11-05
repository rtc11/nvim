return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rouge8/neotest-rust",
        "weilbith/neotest-gradle",
        -- "rtc11/neotest-klib",
        { dir = "~/code/lua/neotest-klib" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-rust"),
                -- require("neotest-gradle"),
                require("neotest-klib")
            },
        })

        require("neotest.logging"):set_level(vim.log.levels.DEBUG)

        vim.keymap.set('n', '<leader>tr', function() require("neotest").run.run() end, { desc = "test run" })
        vim.keymap.set('n', '<leader>tp', function() require("neotest").output_panel.toggle() end, { desc = "test panel" })
        vim.keymap.set('n', '<leader>ts', function() require("neotest").summary.toggle() end, { desc = "test summary" })
    end,


}
