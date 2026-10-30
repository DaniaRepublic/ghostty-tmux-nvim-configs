-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.wrap = true
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.signcolumn = "no" -- Disable the sign column

vim.g.ai_cmp = false
vim.g.lazy_check_on_startup = false -- No auto-update checks

vim.lsp.log.set_level("OFF") -- vim.lsp.set_log_level() is deprecated in 0.12

-- LazyVim leaves the clipboard unsynced over SSH. Inside tmux, sync through tmux's buffer instead:
-- yanks reach the local clipboard via OSC 52 (load-buffer -w), and paste reads tmux's buffer
-- without asking the terminal for its clipboard (which would prompt on every paste).
if vim.env.SSH_CONNECTION and vim.env.TMUX then
  local copy = { "tmux", "load-buffer", "-w", "-" }
  local paste = { "tmux", "save-buffer", "-" }
  vim.g.clipboard = {
    name = "tmux-osc52",
    copy = { ["+"] = copy, ["*"] = copy },
    paste = { ["+"] = paste, ["*"] = paste },
    cache_enabled = 1,
  }
  vim.opt.clipboard = "unnamedplus"
end
