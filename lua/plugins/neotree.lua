return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>pv", "<Cmd>Neotree toggle<CR>")

        require("neo-tree").setup({
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
            },
            buffers = {
                follow_current_file = true, -- This will find and focus the file in the active buffer every
            },
        })
    end,
}
