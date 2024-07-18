return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = false,
				ignore_install = { "javascript" },
				modules = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				auto_install = true,
				ensure_installed = {
					"html",
					"javascript",
					"json",
					"lua",
					"luadoc",
					"luap",
					"query",
					"regex",
					"tsx",
					"typescript",
					"vue",
					"php",
				},
			})
		end,
	},
}
