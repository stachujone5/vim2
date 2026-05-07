local format = require("config.format")
local telescope_actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = telescope_actions.move_selection_previous,
				["<C-j>"] = telescope_actions.move_selection_next,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "ffw", builtin.grep_string, {})
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "gr", builtin.lsp_references, {})
vim.keymap.set("n", "gd", builtin.lsp_definitions, {})

telescope.load_extension("ui-select")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-b>", "<cmd>checktime<CR>", { desc = "Check file changes" })
vim.keymap.set("n", "L", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "<C-f>", function()
	format.format_buffer(vim.api.nvim_get_current_buf())
end, { desc = "Format buffer" })

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
