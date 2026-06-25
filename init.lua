vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.nu = true
opt.wrap = false
opt.hlsearch = false
opt.completeopt = "menu,menuone"
opt.winborder = "rounded"

opt.clipboard = "unnamed"


require("config.lsp")

vim.pack.add({
	"https://github.com/numToStr/Comment.nvim",
}, { load = true, confirm = false })

require("Comment").setup({})


require("config.colorscheme")

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
}, { load = true, confirm = false })

vim.pack.add({
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-path",
}, { load = true, confirm = false })

require("config.cmp")
require("config.tree")
require("config.telescope")
require("config.icons")

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
			on_macro = true,
		})
	end,
})

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<C-b>", "<cmd>checktime<CR>", { desc = "Check file changes" })
