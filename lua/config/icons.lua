vim.pack.add({
	"https://github.com/Mirsmog/real-icons.nvim",
}, { load = true, confirm = false })

require("real-icons").setup({
	pack = "material",
	integrations = {
		telescope = true,
		nvim_tree = true,
	},
})
