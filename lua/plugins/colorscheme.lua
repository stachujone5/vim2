return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "colorscheme",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
}
