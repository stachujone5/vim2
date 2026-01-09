return {
	{
		"catppuccin/nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				no_italic = true,
				no_bold = true,
				no_underline = true,
			})

			vim.cmd.colorscheme("catppuccin-latte")
		end,
	},
}
