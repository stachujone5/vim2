vim.g.mapleader = " "
local opt = vim.opt
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_netrw = 0

opt.encoding = "utf-8"
opt.expandtab = true
opt.nu = true
opt.errorbells = false
opt.wrap = false
opt.smartcase = true
opt.swapfile = false
opt.backup = false
opt.incsearch = true
opt.autoindent = true
opt.hlsearch = false
opt.completeopt = "menu,menuone,noselect"
opt.sw = 2
opt.ts = 2
opt.sts = 2
opt.fillchars = { eob = " " }
opt.cmdheight = 0
vim.o.signcolumn = "yes:1"
vim.o.background = "dark"

vim.api.nvim_set_option("clipboard", "unnamed")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "L", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})

vim.diagnostic.config({
	title = false,
	underline = true,
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = "always",
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "",
	},
})

local highlight_on_yank_group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true })
-- Autocommand for highlighting yanked text
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
