return {
  "saghen/blink.cmp",
  dependencies = {
    "daliusd/blink-cmp-fuzzy-path",
    "archie-judd/blink-cmp-words",
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

    if not opts.sources.providers["thesaurus"] then opts.sources.providers["thesaurus"] = {} end
    opts.sources.providers["thesaurus"] = {
      name = "blink-cmp-words",
      module = "blink-cmp-words.thesaurus",
      opts = {
        score_offset = 0,
        definition_pointers = { "!", "&", "^" },
        similarity_pointers = { "&", "^" },
        similarity_depth = 2,
      },
    }

    if not opts.sources.providers["dictionary"] then opts.sources.providers["dictionary"] = {} end
    opts.sources.providers["dictionary"] = {
      name = "blink-cmp-words",
      module = "blink-cmp-words.dictionary",
      opts = {
        dictionary_search_threshold = 3,
        score_offset = 0,
        definition_pointers = { "!", "&", "^" },
      },
    }

    if not opts.sources["per_filetype"] then opts.sources["per_filetype"] = {} end
    opts.sources["per_filetype"] = {
      text = { "dictionary" },
      markdown = { "thesaurus" },
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
