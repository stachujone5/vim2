vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
}, { load = true, confirm = false })

vim.defer_fn(function()
	require("nvim-web-devicons").setup()
end, 0)

vim.pack.add({
	"https://github.com/nvim-tree/nvim-tree.lua",
}, { load = true, confirm = false })

local function is_image(path)
	return path:match("%.png$")
	    or path:match("%.jpg$")
	    or path:match("%.jpeg$")
	    or path:match("%.svg$")
	    or path:match("%.webp$")
end

local function open_image(path)
	vim.system({ "open", path }, { detach = true })
end

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,

	on_attach = function(bufnr)
		local api = require("nvim-tree.api")

		api.config.mappings.default_on_attach(bufnr)

		local function edit_or_open()
			local node = api.tree.get_node_under_cursor()

			if not node or not node.absolute_path then
				return
			end

			if is_image(node.absolute_path:lower()) then
				open_image(node.absolute_path)
				return
			end

			api.node.open.edit()
		end

		vim.keymap.set("n", "<CR>", edit_or_open, {
			buffer = bufnr,
			noremap = true,
			silent = true,
			desc = "Open file or image externally",
		})
	end,

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
		highlight_diagnostics = "name",
		icons = {
			webdev_colors = true,
			show = {
				file = true,
				folder = false,
				folder_arrow = true,
				git = false,
				modified = true,
				diagnostics = false,
			},
		},
		highlight_git = false,
		symlink_destination = true,
	},

	git = {
		enable = false,
	},

	diagnostics = {
		enable = true,
		show_on_dirs = true,
		debounce_delay = 50,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},

	actions = {
		use_system_clipboard = true,
		open_file = {
			quit_on_open = false,
		},
	},
})

vim.keymap.set("n", "pv", "<cmd>NvimTreeToggle<CR>", {
	desc = "Toggle nvim-tree",
})
