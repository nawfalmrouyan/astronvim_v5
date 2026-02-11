return {
  "2kabhishek/seeker.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "Seeker" },
  keys = {
    { "<leader>Fa", ":Seeker files<CR>", desc = "Seek Files" },
    { "<leader>Ff", ":Seeker git_files<CR>", desc = "Seek Git Files" },
    { "<leader>Fg", ":Seeker grep<CR>", desc = "Seek Grep" },
    { "<leader>Fw", ":Seeker grep_word<CR>", desc = "Seek Grep Word" },
  },
  opts = {}, -- Required unless you call seeker.setup() manually, add your configs here
}
