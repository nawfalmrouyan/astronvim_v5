return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },

  opts = {
    change_directory_command = "cd",
    update_on_change = true,
    update_on_change_command = "e .",
    clearjumps_on_change = true,
    autopush = false,
  },

  keys = {
    {
      "<leader>gws",
      function() require("snacks-worktree").pick_git_worktree() end,
      desc = "Pick Git Worktree",
    },
    {
      "<leader>gwc",
      function() require("snacks-worktree").create_worktree() end,
      desc = "Create Git Worktree",
    },
  },
}
