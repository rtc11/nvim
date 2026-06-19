return {
    -----------------------------------------------------------------------------
    -- kls-debug.nvim — pipe KLS context to opencode for AI-assisted debugging
    -- Local dev install (sibling repo to kls/)
    -----------------------------------------------------------------------------
    dir = "/Users/Robin.Tordly/code/c3/kls-debug.nvim",
    name = "kls-debug.nvim",
    cmd = { "KlsDebugAsk", "KlsDebugChat", "KlsDebugCancel" },
    keys = {
        { "<leader>kd", mode = { "n", "v" }, desc = "kls-debug: ask opencode" },
    },
    opts = {
        output = "split", -- "split" | "float" | "tab"
        keymaps = { enabled = true },
        -- Optional opencode flags:
        -- model = "anthropic/claude-sonnet-4.5",
        -- agent = "build",
        context = {
            diagnostics = true,
            buffer = true,
            selection = true,
            cursor_symbol = true,
            kls = true,
            kls_log = false, -- noisy; flip on when triaging KLS itself
            git = true,
            agents_md = true,
        },
    },
    config = function(_, opts)
        require("kls-debug").setup(opts)
    end,
}
