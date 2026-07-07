return {
  "undont/differ.nvim",
  build = "make go-build",
  cmd = { "Differ", "D" }, -- "D" matches command_alias below; see note above
  keys = {
    -- local diff / history
    { "<leader>Do", "<cmd>Differ<CR>",                        desc = "Diff: open (vs index)" },
    { "<leader>Dc", "<cmd>Differ close<CR>",                  desc = "Diff: close" },
    { "<leader>Dt", "<cmd>Differ base<CR>",                   desc = "Diff: branch total (vs base)" },
    { "<leader>De", "<cmd>Differ gofile<CR>",                 desc = "Diff: open the real file" },
    { "<leader>Dd", "<cmd>Differ panel<CR>",                  desc = "Diff: panel toggle" },
    { "<leader>Dh", "<cmd>Differ log<CR>",                    desc = "Diff: file history" },
 
    { "<leader>Dl", "<cmd>Differ layout<CR>",                 desc = "Diff: toggle layout" },
    -- pr review (sidecar + github)
    { "<leader>Pl", "<cmd>Differ pr list<CR>",                desc = "PR: list" },
    {
      "<leader>Po",
      function()
        vim.ui.input({ prompt = "PR number: " }, function(input)
          if input and input ~= "" then vim.cmd("Differ pr " .. input) end
        end)
      end,
      desc = "PR: open by number",
    },
    { "<leader>Pr",  "<cmd>Differ pr review<CR>",         desc = "PR: review start" },
    { "<leader>Pe",  "<cmd>Differ pr review resume<CR>",  desc = "PR: review resume" },
    { "<leader>Pm",  "<cmd>Differ pr review submit<CR>",  desc = "PR: review submit" },
    { "<leader>Pd",  "<cmd>Differ pr review discard<CR>", desc = "PR: review discard" },
    { "<leader>Psm", "<cmd>Differ pr merge squash<CR>",   desc = "PR: squash merge" },
    { "<leader>Pk",  "<cmd>Differ pr checks<CR>",         desc = "PR: checks" },
    { "<leader>PO",  "<cmd>Differ pr checkout<CR>",       desc = "PR: checkout" },
    { "<leader>PR",  "<cmd>Differ pr ready<CR>",          desc = "PR: mark ready" },
    { "<leader>PD",  "<cmd>Differ pr draft<CR>",          desc = "PR: mark draft" },
    { "<leader>PX",  "<cmd>Differ pr close<CR>",          desc = "PR: close" },
    { "<leader>Pb",  "<cmd>Differ pr browser<CR>",        desc = "PR: open in browser" },
    { "<leader>Py",  "<cmd>Differ pr url<CR>",            desc = "PR: yank URL" },
    { "<leader>Pq",  "<cmd>Differ close<CR>",             desc = "PR: quit" },
  },
  config = function()
    require("differ").setup({ command_alias = "D" })
  end,
}
