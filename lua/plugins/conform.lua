return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<C-f>",
			function()
				require("conform").format({ async = true })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				go = { "golangci-lint" },
				lua = { "stylua" },
			},
		})
	end,
}
