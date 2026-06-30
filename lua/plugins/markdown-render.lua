return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    latex = { enabled = false },
    inline_highlight = {
      enabled = true,
      -- default group for a plain ==text==
      highlight = "RenderMarkdownInlineHighlight",
      -- optional colored variants: prefix lives INSIDE the == ==
      -- e.g. ==!foo== -> red, ==$foo== -> blue
      custom = {
        red = { prefix = "!", highlight = "MdHlRed" },
        blue = { prefix = "?", highlight = "MdHlBlue" },
      },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts) -- keep LazyVim's merged opts
    local function set_hl()
      -- bg makes the highlight actually visible; tweak to taste
      vim.api.nvim_set_hl(0, "RenderMarkdownInlineHighlight", { bg = "#625f10", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "MdHlRed", { bg = "#5f1f1f", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "MdHlBlue", { bg = "#1f3b5f", fg = "#ffffff" })
    end
    set_hl()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
  end,
}
