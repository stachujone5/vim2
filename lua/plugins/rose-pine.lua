return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
}
