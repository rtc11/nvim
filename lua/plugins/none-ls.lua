return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,

        -- js, ts, json, yml, md, graphql, html, css
        null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.eslint_d,

        null_ls.builtins.formatting.ktlint,
        --null_ls.builtins.diagnostics.ktlint,

        null_ls.builtins.formatting.pg_format,

        null_ls.builtins.formatting.protolint,

      },
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
