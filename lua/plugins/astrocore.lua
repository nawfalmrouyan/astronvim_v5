---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      set_number = {
        {
          event = "InsertLeave",
          pattern = "*",
          desc = "Toggle set number when in normal mode",
          group = "set_number",
          callback = function()
            vim.cmd "if &relativenumber | let g:backtorelative = 1 | setlocal number norelativenumber nocursorline | endif"
          end,
        },
      },
      set_relativenumber = {
        {
          event = "InsertLeave",
          pattern = "*",
          desc = "Toggle set number when in normal mode",
          group = "set_relativenumber",
          callback = function() vim.cmd 'if exists("g:backtorelative") | setlocal relativenumber cursorline | endif' end,
        },
      },
      show_diagnostic = {
        {
          event = "CursorHold",
          pattern = "*",
          desc = "show diagnostic on Cursor",
          callback = function() vim.cmd 'lua vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })' end,
        },
      },
    },
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = false, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = false,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        ignorecase = false,
        smartcase = false,
        list = true,
        listchars = { eol = "¬", trail = "·", precedes = "…", extends = "…", tab = "→\\ " },
        showbreak = "﬌ ",
        wrap = true, -- sets vim.opt.wrap
        inccommand = "split",
        colorcolumn = "100",
        -- test highlight only line number.
        cursorline = true,
        cursorlineopt = "both",
        showtabline = 0,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bo"] = { "<cmd>%bd|e#|bd#<cr>", desc = "Close all buffers but the current one" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },
        ["<Leader>a"] = { desc = "Image Clip" },
        ["<Leader>b"] = { desc = "Buffers" },
        ["<Leader>m"] = { desc = "Markdown" },
        ["<Leader>mh"] = { desc = "Headings" },
        ["<Leader>z"] = { desc = "Zk" },
        -- ["<Leader>fs"] = false,

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
        ["<M-o>"] = { "o<esc>", desc = "Insert new line below" },
        ["<M-O>"] = { "O<esc>", desc = "Insert new line above" },
        ["<M-$>"] = { "g$", desc = "End of wrap line" },
        ["/"] = { "ms/", desc = "Search and replace" },
        ["<Esc>"] = { "<Cmd>nohlsearch|diffupdate|normal!<C-l><CR>", desc = "Clear highlights" },
        ["<MiddleMouse>"] = { "i<MiddleMouse><ESC>", desc = "Paste mode" },
        -- From the primeagen
        -- ["J"] = "mzJ`z"
        -- ["<C-d>"] = { "<C-d>zz", desc = "Scroll half page down" },
        -- ["<C-u>"] = { "<C-u>zz", desc = "Scroll half page up" },
        ["n"] = { "nzzzv", desc = "Next search result" },
        ["N"] = { "Nzzzv", desc = "Previous search result" },
        ["Q"] = { "<nop>", desc = "Disable Ex mode" },
        ["<M-w>"] = { ":set wrap! wrap?<cr>", desc = "Toggle wrap" },
        ["<M-r>"] = { ":set relativenumber! relativenumber?<cr>", desc = "Toggle relative number" },
        ["<leader>fs"] = { "<cmd>%s/\\s\\+$//e<cr>:noh<cr>", desc = "Delete trailing whitespace from file" },
        ["gj"] = {
          function()
            vim.cmd "silent! /^##\\+\\s.*$"
            vim.cmd "nohlsearch"
          end,
          desc = "Move to previous markdown header",
        },
        ["gk"] = {
          function()
            vim.cmd "silent! ?^##\\+\\s.*$"
            vim.cmd "nohlsearch"
          end,
          desc = "Move to next markdown header",
        },
      },
      i = {
        ["<M-o>"] = { "<C-o>o", desc = "Insert new line below" },
        ["<M-O>"] = { "<C-o>O", desc = "Insert new line above" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        ["<Esc>"] = { "<C-\\><C-N>", desc = "Escape terminal mode" },
        ["<C-Up>"] = { "<C-\\><C-N>resize -2<cr>", desc = "Resize up" },
        ["<C-Down>"] = { "<C-\\><C-N>resize +2<cr>", desc = "Resize down" },
        ["<C-Left>"] = { "<C-\\><C-N>vertical resize -2<cr>", desc = "Resize left" },
        ["<C-Right>"] = { "<C-\\><C-N>vertical resize +2<cr>", desc = "Resize right" },
      },
      x = {
        ["P"] = { '"_c<c-r>0<esc>', desc = "Better paste" },
      },
    },
  },
}
