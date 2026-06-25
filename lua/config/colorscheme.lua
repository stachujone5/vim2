vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim", name = "kanagawa" },
}, { load = true, confirm = false })

require("kanagawa").setup({
	colors = {
		theme = { all = { ui = { bg_gutter = "none" } } },
	},
})

vim.cmd.colorscheme("kanagawa-dragon")
