return {
    'mhartington/formatter.nvim',
    keys = {
        { "<leader>f", "<cmd>Format<cr>", desc = "Format" },
    },
    config = function()
        local util = require("formatter.util")

        require('formatter').setup({
            filetype = {
                rust = { require('formatter.filetypes.rust').rustfmt },
                c = { require('formatter.filetypes.c').uncrustify },
                zig = { require('formatter.filetypes.zig').zigfmt },
                go = { require('formatter.filetypes.go').gofmt },
                kotlin = { require('formatter.filetypes.kotlin').ktlint },
                ocaml = { require("formatter.filetypes.ocaml").ocamlformat },
                lua = { require('formatter.filetypes.lua').stylua },
                sql = { require('formatter.filetypes.sql').pgformat },
                sh = { require('formatter.filetypes.sh').shfmt },
                json = { require('formatter.filetypes.json').jq },
                toml = { require('formatter.filetypes.toml').taplo },
                yaml = { require('formatter.filetypes.yaml').yamlfmt },
                xml = { require('formatter.filetypes.xml').xmllint },
            },
        })
    end
}
