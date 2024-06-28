vim.g.mapleader = " "

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = " " }

vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.api.nvim_set_option("clipboard", "unnamed")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

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
