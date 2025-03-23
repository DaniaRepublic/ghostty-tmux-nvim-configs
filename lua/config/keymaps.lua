-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- my own keymaps
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true, desc = "Preview markdown" })
vim.keymap.set("n", "<leader>mr", ":redo<CR>", { noremap = true, silent = true, desc = "redo" })
vim.keymap.set("n", "<leader>mu", "<C-u>", { noremap = true, silent = true, desc = "Move up" })
vim.keymap.set("n", "<leader>md", "<C-d>", { noremap = true, silent = true, desc = "Move down" })
vim.keymap.set("n", "<leader>ma", ":%y<CR>", { noremap = true, silent = true, desc = "Copy all lines" })
