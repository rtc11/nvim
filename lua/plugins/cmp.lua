return {
    -----------------------------------------------------------------------------
    ---- crate suggestions in rust toml
    -----------------------------------------------------------------------------
    {
        "saecki/crates.nvim",
        tag = "stable",
        config = function()
            require("crates").setup()
        end,
    },
    -----------------------------------------------------------------------------
    ---- snippet engine
    -----------------------------------------------------------------------------
    {
        "saghen/blink.cmp",
        dependencies = "rafamadriz/friendly-snippets",
        version = "1.*",
        opts = {
            keymap = {
                preset = "none",
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<TAB>"] = { "accept", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono"
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            snippets = { preset = "default" },
        },
        opts_extend = { "sources.default" }
    },
}
