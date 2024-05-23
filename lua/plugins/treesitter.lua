-- Interface to treesitter (syntax highlighting)
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    --opts = {
    --    highlight = { enable = true },
    --    indent = { enable = true },
    --    auto_install = true,
    --},
    config = function()
        require('nvim-treesitter.configs').setup {
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
                enable = false,
            },
        }
    end
}

-- If syntax highlighting is disabled, you can enable it with:
-- :TSDisable highlight
-- :TSEnable highlight
