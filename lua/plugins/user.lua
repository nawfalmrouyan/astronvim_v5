---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
      },
    },
  },

  "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  "max397574/better-escape.nvim",
  -- "dstein64/vim-startuptime",
  -- { "tpope/vim-fugitive", cmd = "G" },

  { "none-ls", optional = true, enabled = true },
  { "aerial", optional = false, enabled = false },
  { "neo-tree.nvim", optional = false, enabled = false },
  -- { "smart-splits.nvim", optional = true, enabled = false },

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
