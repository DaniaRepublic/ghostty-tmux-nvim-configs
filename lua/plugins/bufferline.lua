return {
  {
    "akinsho/bufferline.nvim",
    enabled = false, -- disables the plugin
    opts = {
      options = {
        custom_filter = function(buf_number, buf_numbers)
          local bt = vim.bo[buf_number].buftype
          -- Hide terminal buffers
          if bt == "terminal" then
            return false
          end
          return true
        end,
        indicator = {
          style = "none",
        },
        numbers = function(opts)
          return string.format("%s", opts.raise(opts.ordinal))
        end,
      },
    },
  },
}
