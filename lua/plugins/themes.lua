-- set the colorscheme in init.lua
return {
    {
        "Calder-Ty/Monocle.nvim",
        priority = 1000,
        config = function()
            -- monocle not loaded into neogit, set diff +/- colors manually
            local monocle = require("monocle")
            vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = monocle.colors.black, bg = monocle.colors.limegreen })
            vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = monocle.colors.black, bg = monocle.colors.rose })
        end
    },
    {
        "ficcdaf/ashen.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true;
        },
    },
    {
        "slugbyte/lackluster.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            tweak_backround = {
                normal = 'none'
            }
        }
    },
    {
        "atelierbram/Base2Tone-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- local c = require('base2tone_field_dark.palette')
            -- local hl = vim.api.nvim_set_hl
            -- hl(0, "Normal", { fg = c.B2T_B5, bg = 'NONE',  })
            -- hl(0, "NormalNC", { fg = c.B2T_B5, bg = 'NONE',  })
            -- hl(0, "NormalSB", { fg = c.B2T_B5, bg = 'NONE',  })
        end
    }

}
