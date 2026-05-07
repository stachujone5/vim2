vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-tree/nvim-tree.lua",
}, { load = true, confirm = false })

require("nvim-web-devicons").setup()
require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	view = {
		width = "18%",
		side = "left",
		number = false,
		relativenumber = false,
		signcolumn = "no",
	},

	renderer = {
		indent_width = 0,
		indent_markers = {
			enable = false,
		},
		icons = {
			webdev_colors = true,
			show = {
				file = true,
				folder = false,
				folder_arrow = true,
				git = false,
				modified = true,
			},
		},
		highlight_git = false,
		symlink_destination = true,
	},

	git = {
		enable = false,
	},

	actions = {
		use_system_clipboard = true,
		open_file = {
			quit_on_open = false,
		},
	},
})

vim.keymap.set("n", "pv", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
