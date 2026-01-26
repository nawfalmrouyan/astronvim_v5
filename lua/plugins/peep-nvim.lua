return {
  "lum1nar/peep.nvim",
  opts = {
    fg_color = "#f6c177",
    bg_color = "#44415a",
    peep_duration = 800,
  },
  keys = {
    {
      "<leader><leader>j",
      mode = { "n", "v" },
      function() require("peep").peep() end,
      desc = "Peep",
    },
  },
}
