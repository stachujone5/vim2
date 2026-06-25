vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
}, { load = true, confirm = false })

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
