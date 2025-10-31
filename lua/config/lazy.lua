local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { "nvim-mini/mini.animate", enabled = false },
    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "lazyvim.plugins.extras.dap.core" },
    -- import/override with your plugins
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  checker = {
    enabled = false, -- check for plugin updates periodically
    notify = true, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- remove underlines
local read_hl = vim.api.nvim_get_hl(0, { name = "LspReferenceRead" })
--- @type vim.api.keyset.highlight
local write_hl = read_hl
write_hl.underline = nil
vim.api.nvim_set_hl(0, "LspReferenceWrite", write_hl)
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {})
vim.api.nvim_set_hl(0, "@string.special.url", {})
vim.api.nvim_set_hl(0, "Underlined", {})
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#282727" })

-- removes theme mismatch artifact from status line
local function get_lualine_colors()
  local lualine = require("lualine")
  local theme = lualine.get_config().options.theme
  -- If the theme is a string, require it; otherwise, it's already a table
  if type(theme) == "string" then
    theme = require("lualine.themes." .. theme)
  end
  local normal = theme.normal.c
  return { fg = normal.fg, bg = normal.bg }
end

local function set_statusline_highlight()
  local colors = get_lualine_colors()
  vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.bg, fg = colors.fg })
end

-- Call the function to set the highlight
set_statusline_highlight()
