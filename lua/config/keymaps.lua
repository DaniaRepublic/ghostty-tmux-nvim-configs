-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- my own keymaps
vim.keymap.set("n", "<leader>m", "", { silent = true, desc = "my bindigs" })
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

-- run make
vim.keymap.set("n", "<leader>r", "", { desc = "run", silent = true })
vim.keymap.set("n", "<leader>rd", function()
  -- 1) Find an existing terminal buffer
  local term_buf
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_loaded(buf) then
      term_buf = buf
      break
    end
  end
  -- 2) If found, split and go to it; otherwise create a new one
  if term_buf then
    vim.cmd("split | buffer " .. term_buf)
  else
    vim.cmd("split | terminal")
    term_buf = vim.api.nvim_get_current_buf()
  end
  -- 3) Enter the terminal’s Insert mode
  vim.cmd("startinsert")
  -- 4) Send "make" + Enter to that terminal job
  local chan = vim.api.nvim_buf_get_var(term_buf, "terminal_job_id")
  vim.fn.chansend(chan, "make all-dev\n")
end, { desc = "Cmake for dev.", silent = true })

vim.keymap.set("n", "<leader>rt", function()
  -- 1) Find an existing terminal buffer
  local term_buf
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_loaded(buf) then
      term_buf = buf
      break
    end
  end
  -- 2) If found, split and go to it; otherwise create a new one
  if term_buf then
    vim.cmd("split | buffer " .. term_buf)
  else
    vim.cmd("split | terminal")
    term_buf = vim.api.nvim_get_current_buf()
  end
  -- 3) Enter the terminal’s Insert mode
  vim.cmd("startinsert")
  -- 4) Send "make" + Enter to that terminal job
  local chan = vim.api.nvim_buf_get_var(term_buf, "terminal_job_id")
  vim.fn.chansend(chan, "make all-target\n")
end, { desc = "Cmake for target.", silent = true })

-- Normal mode: If in terminal buffer, pressing <Esc> goes to insert mode
vim.keymap.set("n", "<Esc>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("startinsert")
  else
    vim.cmd("nohlsearch")
  end
end, { noremap = true, silent = true })

-- Terminal mode: <Esc> leaves terminal mode and hides the terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:hide<CR>]], { noremap = true, silent = true })

-- Terminal mode: Ctrl+n to just leave terminal mode
vim.keymap.set("t", "<C-z>", [[<C-\><C-n>]], { noremap = true, silent = true })

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a)
      return a.isPreferred
    end,
    apply = true,
  })
end

vim.keymap.set("n", "<leader>qf", quickfix, { noremap = true, silent = true, desc = "Quick fix" })
