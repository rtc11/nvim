-- Hover / signature help with rounded border + size limits
vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover({
        border = 'rounded',
        max_width = 80,
        max_height = 20,
    })
end, { desc = 'LSP hover' })

vim.keymap.set({ 'n', 'i' }, '<C-k>', function()
    vim.lsp.buf.signature_help({
        border = 'rounded',
        max_width = 80,
        max_height = 20,
    })
end, { desc = 'LSP signature help' })

vim.diagnostic.config({
    float = {
        border = 'rounded',
    },
})

-- Give floating windows a visible background + border when using the
-- `ashen` colorscheme (which is transparent and otherwise blends in).
local function apply_ashen_float_hl()
    local ok, palette = pcall(require, 'ashen.variants.default.colors')
    if not ok then return end

    local bg     = palette.g_11        -- "#191919" — slightly lifted from background
    local border = palette.g_7         -- "#535353" — visible but muted
    local fg     = palette.g_2         -- "#d5d5d5"

    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = bg, fg = fg })
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = bg, fg = border })
    vim.api.nvim_set_hl(0, 'FloatTitle',  { bg = bg, fg = fg, bold = true })
end

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'ashen',
    callback = apply_ashen_float_hl,
})

-- Apply immediately if ashen is already active when this file is loaded.
if vim.g.colors_name == 'ashen' then
    apply_ashen_float_hl()
end

return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "kotlin_lsp",
            },
        },
    },
}
