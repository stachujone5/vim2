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
					transparency = true,
				},
			})
			vim.cmd.colorscheme("rose-pine")
            vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
		end,
	},
}
