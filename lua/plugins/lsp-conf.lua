return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },

    servers = {
      solidity_ls = {
        enabled = false,
        mason = false,
      },

      solidity_ls_nomicfoundation = {},

      marksman = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
            if result.diagnostics then
              local filtered_diagnostics = {}
              for _, diag in ipairs(result.diagnostics) do
                -- The "%-" is used because "-" is a magic character in Lua pattern matching
                if not string.match(diag.message, "Link to non%-existent heading") then
                  table.insert(filtered_diagnostics, diag)
                end
              end
              result.diagnostics = filtered_diagnostics
            end
            -- Pass the filtered diagnostics to Neovim's default handler
            vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
          end,
        },
      },

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
