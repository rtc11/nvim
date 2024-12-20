-- set the colorscheme in init.lua
return {
    {
        "Calder-Ty/Monocle.nvim",
        priority = 1000,
        config = function ()
            -- monocle not loaded into neogit, set diff +/- colors manually
            local monocle = require("monocle")
            vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = monocle.colors.black, bg = monocle.colors.limegreen })
            vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = monocle.colors.black, bg = monocle.colors.rose })
        end
    }
}
