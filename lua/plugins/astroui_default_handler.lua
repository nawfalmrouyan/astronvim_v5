return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    handlers = {
      ["*"] = function(server)
        -- If you need the LSP options for a server use `vim.lsp.config` table
        -- This is useful for cases of setting up language server specific plugins
        local opts = vim.lsp.config[server]
        vim.lsp.enable(server)
      end,
    },
  },
}
