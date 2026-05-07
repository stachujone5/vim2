vim.g.mapleader = " "

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 17

local opt = vim.opt
opt.nu = true
opt.wrap = false
opt.hlsearch = false
opt.completeopt = "menu,menuone,noselect"
opt.clipboard = "unnamed"
opt.winborder = "rounded"
