return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neotree = require("neo-tree")

		neotree.setup({
			default_component_configs = {
				name = {
					use_git_status_colors = false,
				},
				git_status = {
					symbols = {
						-- Don't show any icons in the file tree
						added = "",
						modified = "",
						deleted = "",
						renamed = "",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			window = {
				mappings = {
					["<tab>"] = { "toggle_preview", config = { use_float = true } },
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
						".git",
					},
				},
				follow_current_file = true, -- This will find and focus the file in the active buffer every
				window = {
					mappings = {
						["<C-g>"] = "next_git_modified",
					},
					fuzzy_finder_mappings = {
						-- define keymaps for filter popup window in fuzzy_finder_mode
						["<C-j>"] = "move_cursor_down",
						["<C-k>"] = "move_cursor_up",
					},
				},
			},
			buffers = {
				follow_current_file = true, -- This will find and focus the file in the active buffer every
			},
		})

		vim.api.nvim_create_augroup("neotree", {})
		vim.api.nvim_create_autocmd("UiEnter", {
			desc = "Open Neotree automatically",
			group = "neotree",
			callback = function()
				if vim.fn.argc() == 0 then
					vim.cmd("Neotree toggle")
				end
			end,
		})
	end,
}
