return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = on_attach_change,
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
      update_focused_file = {
        enable = true,
      }
    }
  }
}
