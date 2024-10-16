-- set the colorscheme in init.lua
return {
    {
        "scottmckendry/cyberdream.nvim",
        -- lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
        }
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "night",
        }
    },
    {
        "rmehri01/onenord.nvim",
        priority = 1000,
        opts = {
            disable = {
                background = true,
            }
        }
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    {
        'navarasu/onedark.nvim',
        priority = 1000
    },
    {
        'AlexvZyl/nordic.nvim',
        priority = 1000,
        opts = {
            swap_background = true,
            transparent_bg = true,
        }
    },
    {
        "owickstrom/vim-colors-paramount",
        priority = 1000,
    },
    {
        "Patagia/dieter.nvim",
        priority = 1000,
    },
    {
        "Calder-Ty/Monocle.nvim",
        priority = 1000,
    }
}
