---@type LazySpec
return {

  -- == Examples of Adding Plugins ==
  --
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
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  "max397574/better-escape.nvim",
  "dstein64/vim-startuptime",

  { "none-ls", optional = true, enabled = true },
  { "aerial", optional = true, enabled = false },
  { "neo-tree.nvim", optional = true, enabled = false },

  { "RRethy/nvim-treesitter-textsubjects", event = "User AstroFile", before = "nvim-treesitter" },

  -- { "tpope/vim-fugitive", cmd = "G" },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = { need = 0 },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      },
    },
  },

  -- == Examples of Overriding Plugins ==

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

  {
    "neo-tree.nvim",
    optional = true,
    enabled = false,
  },

  {
    "smart-splits.nvim",
    optional = true,
    enabled = false,
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
}
