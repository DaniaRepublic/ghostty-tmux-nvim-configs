return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
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
