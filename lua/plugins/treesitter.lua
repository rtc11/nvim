-- Interface to treesitter (syntax highlighting)
return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = "main",
        build = { ":TSUpdate" },
        init = function ()
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    local filetype = args.match
                    local lang = vim.treesitter.language.get_lang(filetype)
                    if not vim.tbl_contains(require("nvim-treesitter.config").get_available(), lang) then return end
                    require("nvim-treesitter").install(lang):await(function()
                        vim.wo.foldlevel = 20
                        vim.wo.foldmethod = 'expr'
                        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        vim.treesitter.start()
                    end)
                end,
            })
        end,
    }
}
-- TOGGLE SYNTAX HIGHLIGHTER
-- :TSDisable highlight
-- :TSEnable highlight

-- INSPECT SYNTAX HIGHLIGHTER
-- :InspecTree

-- SET FILE TYPE FOR SYNTAX
-- :set filetype=scala
