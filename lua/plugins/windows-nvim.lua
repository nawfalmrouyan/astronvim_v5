return {
  {
    "JoseConseco/windows.nvim",
    requires = {
      "JoseConseco/middleclass",
      "anuvyklack/animation.nvim",
    },
    keys = {
      { "<A-=>", "<Cmd>WindowsMaximize<CR>", desc = "Maximize window" },
      { "<A-=>", "<C-\\><C-n><Cmd>WindowsMaximize<CR>i", mode = "t", desc = "Maximize window" },
      { "<A-/>", "<Cmd>WindowsMaximizeVertically<CR>", desc = "Maximize window vertically" },
      { "<A-->", "<Cmd>WindowsMaximizeHorizontally<CR>", desc = "Maximize window horizontally" },
      { "<A-0>", "<Cmd>WindowsEqualize<CR>", desc = "Equalize windows" },
    },
    config = function()
      vim.o.winwidth = 20
      vim.o.winminwidth = 20
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
}
