return {
	{
		"jay-babu/mason-null-ls.nvim",
		config = function()
			require("mason-null-ls").setup({
				automatic_installation = {},
				-- Each of one of these needs to be added in the configuration for none-ls.nvim
				ensure_installed = {
					"prettierd",
					"stylua",
					"eslint_d",
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
				require("none-ls.code_actions.eslint_d"),
				require("none-ls.diagnostics.eslint_d"),
			})

			vim.keymap.set("n", "<C-f>", function()
				vim.lsp.buf.format({
					filter = function(client)
						-- Needs to be done better - prettier and eslint_d formatted via lsp not null-ls are bugged
						local filetype = vim.bo.filetype
						if filetype == "rust" or filetype == "go" then
							return true
						else
							return client.name == "null-ls"
						end
					end,
				})
			end)
		end,
	},
}
