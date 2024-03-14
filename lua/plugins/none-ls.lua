return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
			},
		})

		vim.api.nvim_set_keymap("n", "<C-s>", "", {
			callback = function()
				vim.lsp.buf.format()
				vim.cmd("w!")
			end,
		})
	end,
}
