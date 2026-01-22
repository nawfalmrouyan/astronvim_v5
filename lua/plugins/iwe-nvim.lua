return {
  "iwe-org/iwe.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    require("iwe").setup {
      lsp = {
        cmd = { "iwes" },
        auto_format_on_save = true,
        enable_inlay_hints = true,
        debounce_text_changes = 500,
      },
      mappings = {
        enable_markdown_mappings = true, -- core markdown editing keybindings
        enable_picker_keybindings = true, -- set to true to enable gf, gs, ga, g/, gb, gr, go
        enable_lsp_keybindings = true, -- set to true to enable iwe-specific lsp keybindings
        enable_preview_keybindings = true, -- set to true to enable preview keybindings
        leader = "<leader>",
        localleader = "<localleader>",
      },
      picker = {
        backend = "snacks", -- "auto", "telescope", "fzf_lua", "snacks", "mini", "vim_ui"
        fallback_notify = true,
      },
      preview = {
        output_dir = "~/tmp/preview",
        temp_dir = "/tmp",
        auto_open = false,
      },
      -- Picker keybindings
      vim.keymap.set("n", "gf", "<Plug>(iwe-picker-find-files)"),
      vim.keymap.set("n", "gs", "<Plug>(iwe-picker-paths)"),
      vim.keymap.set("n", "ga", "<Plug>(iwe-picker-roots)"),
      vim.keymap.set("n", "g/", "<Plug>(iwe-picker-grep)"),
      vim.keymap.set("n", "gb", "<Plug>(iwe-picker-blockreferences)"),
      vim.keymap.set("n", "gR", "<Plug>(iwe-picker-backlinks)"),
      vim.keymap.set("n", "go", "<Plug>(iwe-picker-headers)"),

      -- LSP keybindings
      vim.keymap.set("n", "<CR>", "<Plug>(iwe-lsp-go-to-definition)"),
      vim.keymap.set("v", "<CR>", "<Plug>(iwe-lsp-link)"),
      vim.keymap.set("n", "<leader>h", "<Plug>(iwe-lsp-rewrite-list-section)"),
      vim.keymap.set("n", "<leader>l", "<Plug>(iwe-lsp-rewrite-section-list)"),

      -- Preview keybindings
      vim.keymap.set("n", "<leader>ps", "<Plug>(iwe-preview-squash)"),
      vim.keymap.set("n", "<leader>pe", "<Plug>(iwe-preview-export)"),
      vim.keymap.set("n", "<leader>ph", "<Plug>(iwe-preview-export-headers)"),
      vim.keymap.set("n", "<leader>pw", "<Plug>(iwe-preview-export-workspace)"),
    }
  end,
}
