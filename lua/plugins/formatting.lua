return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- 1. Assign the formatter to the filetype
      formatters_by_ft = {
        rust = { "rustfmt" },
        solidity = { "prettier" },
      },
      -- 2. Customize the rustfmt command to use nightly
      formatters = {
        rustfmt = {
          command = "rustup",
          args = { "run", "nightly", "rustfmt", "--emit=stdout" },
        },
      },
    },
  },
}
