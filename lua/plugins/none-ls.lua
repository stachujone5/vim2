return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		vim.keymap.set("n", "<C-f>", vim.lsp.buf.format)
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.diagnostics.eslint_d,
			},
		})
	end,
}
