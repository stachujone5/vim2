local highlight_on_yank_group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_on_yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		on_macro = true,
	})
	end,
})
