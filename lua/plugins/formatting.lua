return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        swift = { "swiftformat" },
      },
      -- Optional: Customize swiftformat args if needed (e.g., for specific rules)
      formatters = {
        swiftformat = {
          prepend_args = { "--indent", "4" },
        },
      },
    },
  },
}
