return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      sourcekit = {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      },
      clangd = {
        cmd = { "clangd", "--compile-commands-dir=." },
      },
    },
  },
}
