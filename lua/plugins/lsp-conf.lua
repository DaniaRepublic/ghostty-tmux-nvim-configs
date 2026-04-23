return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },

    servers = {
      -- 1. Completely disable the old Solidity LSP
      solidity_ls = {
        enabled = false,
        mason = false,
      },

      -- 2. Boot up the new Nomic Foundation (Hardhat) LSP instead
      solidity_ls_nomicfoundation = {},

      -- Your existing configs remain untouched below:
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
