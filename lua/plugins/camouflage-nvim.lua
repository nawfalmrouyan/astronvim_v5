return {
  "zeybek/camouflage.nvim",
  enabled = false,
  event = "VeryLazy",
  enabled = false,
  opts = {},
  keys = {
    { "<leader>c", nil },
    { "<leader>ct", "<cmd>CamouflageToggle<cr>", desc = "Toggle Camouflage" },
    { "<leader>cr", "<cmd>CamouflageReveal<cr>", desc = "Reveal Line" },
    { "<leader>cy", "<cmd>CamouflageYank<cr>", desc = "Yank Value" },
    { "<leader>cf", "<cmd>CamouflageFollowCursor<cr>", desc = "Follow Cursor" },
  },
}
