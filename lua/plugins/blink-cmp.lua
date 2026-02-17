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
        -- A score offset applied to returned items.
        -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
        score_offset = 0,

        -- Default pointers define the lexical relations listed under each definition,
        -- see Pointer Symbols below.
        -- Default is as below ("antonyms", "similar to" and "also see").
        definition_pointers = { "!", "&", "^" },

        -- The pointers that are considered similar words when using the thesaurus,
        -- see Pointer Symbols below.
        -- Default is as below ("similar to", "also see" }
        similarity_pointers = { "&", "^" },

        -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
        -- 2 is similar words of similar words, etc. Increasing this may slow results.
        similarity_depth = 2,
      },
    }

    if not opts.sources.providers["dictionary"] then opts.sources.providers["dictionary"] = {} end
    opts.sources.providers["dictionary"] = {
      name = "blink-cmp-words",
      module = "blink-cmp-words.dictionary",
      opts = {
        -- The number of characters required to trigger completion.
        -- Set this higher if completion is slow, 3 is default.
        dictionary_search_threshold = 3,

        -- See above
        score_offset = 0,

        -- See above
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
