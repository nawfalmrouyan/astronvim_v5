return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      ensure_installed = { "vim", "lua" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      textobjects = {
        select = {
          select_textobject = {
            ["ak"] = { query = "@block.outer", desc = "around block" },
          },
        },
      },
    },
  },
}
