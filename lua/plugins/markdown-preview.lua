return {
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown", -- load only for markdown files
    build = "cd app && npm install", -- install dependencies
    config = function()
      -- Optional: adjust settings as needed
      vim.g.mkdp_auto_start = 0 -- don't auto-open preview on file open
      vim.g.mkdp_auto_close = 1 -- auto-close preview when quitting vim
      vim.g.mkdp_refresh_slow = 0 -- set to 1 if you experience slow refresh
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_browser = "" -- use default system browser
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
