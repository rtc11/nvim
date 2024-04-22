-- Interface to treesitter (syntax highlighting)
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
    }
}

