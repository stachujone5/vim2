vim.pack.add({
	{ src = "https://github.com/projekt0n/github-nvim-theme", name = "github-theme" },
}, { load = true, confirm = false })

require("github-theme").setup({})
vim.cmd.colorscheme("github_dark_default")

vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
