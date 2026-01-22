return {
  "blink.cmp",
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
  end,
}
