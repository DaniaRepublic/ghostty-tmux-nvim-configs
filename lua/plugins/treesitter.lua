return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "swift", "lua", "vim", "vimdoc" }, -- Include Swift and other useful parsers
    sync_install = false, -- Install parsers asynchronously (recommended for LazyVim)
    auto_install = true, -- Automatically install parsers for detected filetypes
    ignore_install = {}, -- List of parsers to ignore (empty by default)
    modules = {}, -- Required field, can be empty (used for modular Treesitter features)
    highlight = { enable = true }, -- Enable syntax highlighting
    indent = { enable = true }, -- Enable Treesitter-based indentation
  },
}
