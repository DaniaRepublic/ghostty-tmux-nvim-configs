-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Automatically stop preview when leaving a markdown file
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*.md",
  callback = function()
    vim.cmd("MarkdownPreviewStop")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "swift",
  callback = function()
    vim.opt_local.shiftwidth = 4 -- Indent size for autoindent and shifting
    vim.opt_local.tabstop = 4 -- How many spaces a tab counts for
    vim.opt_local.softtabstop = 4 -- Tab key inserts this many spaces
    vim.opt_local.expandtab = true -- Use spaces instead of tabs
    vim.opt_local.smartindent = true -- Auto-indent after {, deindent } properly
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "solidity" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    -- Tell Neovim about /// comments
    vim.opt_local.comments:prepend(":///")

    -- Ensure Neovim automatically continues comments on `<Enter>` (r) and `o`/`O` (o)
    vim.opt_local.formatoptions:append("ro")
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Link Tree-sitter note/todo groups to the normal 'Comment' group
    vim.api.nvim_set_hl(0, "@comment.note", { link = "Comment" })
    vim.api.nvim_set_hl(0, "@comment.todo", { link = "Comment" })
    vim.api.nvim_set_hl(0, "@comment.warning", { link = "Comment" })
    vim.api.nvim_set_hl(0, "@comment.error", { link = "Comment" })

    -- Also link the standard Vim 'Todo' group
    vim.api.nvim_set_hl(0, "Todo", { link = "Comment" })
  end,
})
