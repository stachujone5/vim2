return {
	{
		"jay-babu/mason-null-ls.nvim",
		config = function()
			require("mason-null-ls").setup({
				automatic_installation = {},
				-- Each of one of these needs to be added in the configuration for none-ls.nvim
				ensure_installed = {
					"prettierd",
					"gopls",
					"stylua",
					"eslint",
				},
			})
		end,
		lazy = true,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		lazy = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = vim.list_extend(opts.sources or {}, {
				-- Formatter
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.prettierd,

				-- Linter
				require("none-ls.code_actions.eslint"),
				require("none-ls.diagnostics.eslint"),
			})

		end,
	},
}
