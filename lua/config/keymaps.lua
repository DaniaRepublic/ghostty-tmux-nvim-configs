-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- my own keymaps
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true, desc = "Preview markdown" })
vim.keymap.set("n", "<leader>mr", ":redo<CR>", { noremap = true, silent = true, desc = "redo" })
vim.keymap.set("n", "<leader>mu", "<C-u>", { noremap = true, silent = true, desc = "Move up" })
vim.keymap.set("n", "<leader>md", "<C-d>", { noremap = true, silent = true, desc = "Move down" })
vim.keymap.set("n", "<leader>ma", ":%y<CR>", { noremap = true, silent = true, desc = "Copy all lines" })
vim.keymap.set("n", "<leader>fs", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("x", "<leader>p", [["_dP]], { noremap = true, silent = true, desc = "Discard deleted by paste" })
vim.keymap.set("n", "<leader>t", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd("split | buffer " .. buf)
      vim.cmd("startinsert")
      return
    end
  end
  vim.cmd("split | terminal")
  vim.cmd("startinsert")
end, { desc = "Toggle terminal", silent = true })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:hide<CR>]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], { noremap = true, silent = true })

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a)
      return a.isPreferred
    end,
    apply = true,
  })
end

vim.keymap.set("n", "<leader>qf", quickfix, { noremap = true, silent = true, desc = "Quick fix" })
