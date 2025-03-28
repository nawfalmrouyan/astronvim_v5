return {
  { -- further customize the options set by the community
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      -- custom_highlights = function(colors)
      --   local u = require "catppuccin.utils.colors"
      --   return {
      --     CursorLine = {
      --       bg = u.vary_color(
      --         { latte = u.lighten(colors.mantle, 0.70, colors.base) },
      --         u.darken(colors.surface0, 0.64, colors.base)
      --       ),
      --     },
      --   }
      -- end,
      integrations = {
        -- aerial = true,
        -- alpha = true,
        blink_cmp = true,
        -- dadbod_ui = true,
        dap = true,
        dashboard = true,
        -- fzf = true,
        gitsigns = true,
        -- indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = true,
        neotest = true,
        noice = true,
        notify = true,
        -- nvim_surround = true,
        quickfix = true,
        render_markdown = true,
        semantic_tokens = true,
        snacks = true,
        symbol_outline = true,
        treesitter = true,
        treesitter_context = true,
        ts_rainbow2 = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "italic" },
            warnings = { "undercurl" },
            information = { "italic" },
          },
        },
      },
    },
    config = function() require("catppuccin").setup {} end,
  },
}
