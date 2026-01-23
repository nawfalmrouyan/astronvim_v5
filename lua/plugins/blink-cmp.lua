return {
  "saghen/blink.cmp",
  dependencies = {
    "daliusd/blink-cmp-fuzzy-path",
  },
  opts = function(plugin, opts)
    table.insert(opts.sources.default, "fuzzy-path")

    if not opts.sources.providers["fuzzy-path"] then opts.sources.providers["fuzzy-path"] = {} end

    opts.sources.providers["fuzzy-path"] = {
      name = "Fuzzy Path",
      module = "blink-cmp-fuzzy-path",
      score_offset = 0,
      opts = {
        filetypes = { "markdown", "json" }, -- optional
      },
    }

    if not opts.keymap then opts.keymap = {} end

    opts.keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "cancel", "fallback" },
    }
  end,
}
