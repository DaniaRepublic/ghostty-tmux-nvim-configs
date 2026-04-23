return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      -- "disabled"  : disable neo-tree netrw hijacking entirely
      -- "open_current" : open in current window (LazyVim default)
      -- "open_default" : open in a split (standard default)
      hijack_netrw_behavior = "disabled",
    },
  },
}
