return {
  {
    -- "zk-org/zk-nvim",
    "pkazmier/zk-nvim",
    branch = "snacks-picker",
    cmd = {
      "ZkNewFromTitleSelection",
      "ZkNewFromContentSelection",
      "ZkNotes",
      "ZkTags",
      "ZkMatch",
      "ZkNew",
      "ZkOrphans",
      "ZkRecents",
    },
    ft = "markdown",
    config = function()
      require("zk").setup {
        picker = "snacks_picker",
        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },
        },
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      }

      local zk = require "zk"
      local commands = require "zk.commands"

      local function make_edit_fn(defaults, picker_options)
        return function(options)
          options = vim.tbl_extend("force", defaults, options or {})
          zk.edit(options, picker_options)
        end
      end

      commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
      commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))

      local function cmd(command) return table.concat { "<Cmd>", command, "<CR>" } end

      vim.keymap.set("n", "<Leader>zn", cmd "ZkNotes")
      vim.keymap.set("n", "<Leader>zr", cmd "ZkRecents")
      vim.keymap.set("n", "<Leader>zt", cmd "ZkTags")
      vim.keymap.set("n", "<Leader>zo", cmd "ZkOrphans")
    end,
  },
}
