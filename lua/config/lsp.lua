vim.pack.add {
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.config('rust_analyzer', {
	settings = {
		['rust-analyzer'] = {},
	},
})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {},
	},
})

vim.lsp.config('biome', {})

vim.lsp.config('ts_ls', {})

vim.lsp.enable({ "rust_analyzer", "lua_ls", "biome", "ts_ls" })

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	float = {
		source = true,
		border = "rounded",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if client:supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<C-f>", function()
				vim.lsp.buf.format({
					bufnr = ev.buf,
					id = client.id,
					timeout_ms = 1000,
				})
			end, { buffer = ev.buf, desc = "LSP Format" })
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "K", vim.lsp.buf.hover, "LSP Hover")
		map("n", "<leader>r", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
	end,
})

vim.keymap.set("n", "L", vim.diagnostic.open_float, { desc = "Line diagnostics" })
