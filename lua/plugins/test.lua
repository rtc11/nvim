return {
    ---------------------------------------------------------------------------
    -- Test
    -----------------------------------------------------------------------------
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rouge8/neotest-rust",
        "weilbith/neotest-gradle",
        -- "rtc11/neotest-klib",
        -- { dir = "~/code/lua/neotest-klib" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-rust"),
                -- custom adapter for the helved-utbetaling monorepo.
                -- replaces neotest-gradle, which breaks on Gradle 8 because
                -- `gradle properties --property testResultsDir` returns "null"
                -- and the adapter then looks for "null/test".
                require("neotest-helved"),
                -- require("neotest-gradle"),
                -- require("neotest-klib")
            },
        })

        require("neotest.logging"):set_level(vim.log.levels.DEBUG)

        -- Neotest's output viewer renders into an embedded terminal buffer
        -- (via nvim_open_term + nvim_chan_send), which interprets ANSI
        -- escape codes natively. Terminal rendering relies on
        -- g:terminal_color_0..15 being set; the lackluster colorscheme
        -- doesn't set them, so colored Gradle/Logback output reads as
        -- monochrome. Define a reasonable 16-color palette here so the
        -- terminal buffer can colorize properly.
        local term_colors = {
            "#1e1e1e", -- 0  black
            "#cc6666", -- 1  red
            "#a6e3a1", -- 2  green
            "#f9e2af", -- 3  yellow
            "#89b4fa", -- 4  blue
            "#cba6f7", -- 5  magenta
            "#94e2d5", -- 6  cyan
            "#cdd6f4", -- 7  white
            "#585b70", -- 8  bright black
            "#f38ba8", -- 9  bright red
            "#a6e3a1", -- 10 bright green
            "#f9e2af", -- 11 bright yellow
            "#89b4fa", -- 12 bright blue
            "#f5c2e7", -- 13 bright magenta
            "#94e2d5", -- 14 bright cyan
            "#ffffff", -- 15 bright white
        }
        for i, color in ipairs(term_colors) do
            vim.g["terminal_color_" .. (i - 1)] = color
        end

        vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "test run" })
        vim.keymap.set("n", "<leader>tp", function() require("neotest").output_panel.toggle() end, { desc = "test panel" })
        vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "test summary" })
    end,
}
