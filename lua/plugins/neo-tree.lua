return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = { position = "current" },
    filesystem = {
      bind_to_cwd = true,
      cwd_target = {
        sidebar = "global",
        current = "global",
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Explorer (cwd)",
    },
    { "<leader>E", false }, -- optional: disable the cwd variant since <leader>e now does that
  },
}
