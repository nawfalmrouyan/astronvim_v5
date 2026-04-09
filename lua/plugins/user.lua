---@type LazySpec
return {
  "andweeb/presence.nvim",
  "max397574/better-escape.nvim",

  { "none-ls",           optional = false, enabled = false },
  { "aerial",            optional = false, enabled = false },
  { "neo-tree.nvim",     optional = false, enabled = false },
  { "smart-splits.nvim", optional = false, enabled = false },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = { need = 0 },
  },

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "█████████████████████████████████████████████████",
            "█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█",
            "█░░░░░░░░░░░░░░░░░░░█▀▀▀░█░░░░░░░░█░░░█░█░░░░░░░█",
            "█░░░░░░░░░░░█░░░█░░░▀▀▀█░█░░░█▀█░░█░░░█░█░░░░░░░█",
            "█░░░░░░░░░░░█▀▀▀▀▀▀▀▀▀▀▀░▀░░░▀▀▀▀▀▀▀▀▀▀░▀░░░░░░░█",
            "█░░░░░░░▀▀▀▀▀░░░▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█",
            "█████████████████████████████████████████████████",
          }, "\n"),
        },
      },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
      bigfile = {},
      explorer = {},
      quickfile = {},
      statuscolumn = {},
      words = {},
      scroll = {},
      picker = {
        sources = {
          grep = {
            need_search = false,
            live = false,
          },
        },
      },
    },
  },
}
