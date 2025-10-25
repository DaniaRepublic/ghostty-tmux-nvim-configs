return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = function(_, opts)
    -- Add swift to ensure_installed
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "swift" })
    end
    -- Disable indent for swift
    if type(opts.indent) == "table" then
      opts.indent.disable = opts.indent.disable or {}
      vim.list_extend(opts.indent.disable, { "swift" })
    end
    return opts
  end,
}
