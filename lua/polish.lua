-- Set up custom filetypes
vim.filetype.add {
  extension = {
    -- foo = "fooscript",
  },
  filename = {
    -- ["Foofile"] = "fooscript",
    [".env"] = "config",
    [".todo"] = "txt",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
    ["req.*.txt"] = "config",
    ["gitconf.*"] = "gitconfig",
    [".*/hyprland%.conf"] = "hyprlang",
  },
}

-- vim.opt.guicursor = {
--   "n-v:block-block-Cursor/lCursor",
--   "i-c-ci-ve:ver25-Cursor/lCursor",
--   "r-cr:hor20",
--   "o:hor50",
--   "i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
--   "sm:block-blinkwait175-blinkoff150-blinkon175",
-- }

require "neovide"
require "keymaps"

vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = vim.api.nvim_create_augroup("LeapOnSearch", {}),
  callback = function()
    local ev = vim.v.event
    local is_search_cmd = (ev.cmdtype == "/") or (ev.cmdtype == "?")
    local cnt = vim.fn.searchcount().total
    if is_search_cmd and not ev.abort and (cnt > 1) then
      -- Allow CmdLineLeave-related chores to be completed before
      -- invoking Leap.
      vim.schedule(function()
        -- We want "safe" labels, but no auto-jump (as the search
        -- command already does that), so just use `safe_labels`
        -- as `labels`, with n/N removed.
        local labels = require("leap").opts.safe_labels:gsub("[nN]", "")
        -- For `pattern` search, we never need to adjust conceallevel
        -- (no user input). We cannot merge `nil` from a table, but
        -- using the option's current value has the same effect.
        local vim_opts = { ["wo.conceallevel"] = vim.wo.conceallevel }
        require("leap").leap {
          pattern = vim.fn.getreg "/", -- last search pattern
          windows = { vim.fn.win_getid() },
          opts = { safe_labels = "", labels = labels, vim_opts = vim_opts },
        }
      end)
    end
  end,
})

do
  local function ft(key_specific_args)
    require("leap").leap(vim.tbl_deep_extend("keep", key_specific_args, {
      -- Uncomment to limit search scope to the current line:
      -- pattern = function(pat) return '\\%.l' .. pat end,
      inputlen = 1,
      inclusive = true,
      opts = {
        -- Force autojump.
        labels = "",
        -- Match the modes where you don't need labels (`:h mode()`).
        safe_labels = vim.fn.mode(1):match "o" and "" or nil,
      },
    }))
  end

  -- A helper function making it easier to set "clever-f" behavior
  -- (use f/F or t/T instead of ;/, - see the plugin clever-f.vim).
  local clever = require("leap.user").with_traversal_keys
  local clever_f, clever_t = clever("f", "F"), clever("t", "T")

  vim.keymap.set({ "n", "x", "o" }, "f", function() ft { opts = clever_f } end)
  vim.keymap.set({ "n", "x", "o" }, "F", function() ft { backward = true, opts = clever_f } end)
  vim.keymap.set({ "n", "x", "o" }, "t", function() ft { offset = -1, opts = clever_t } end)
  vim.keymap.set({ "n", "x", "o" }, "T", function() ft { backward = true, offset = 1, opts = clever_t } end)
end

vim.keymap.set({ "n", "x", "o" }, "|", function()
  local line = vim.fn.line "."
  -- Skip 3-3 lines around the cursor.
  local top, bot = unpack { math.max(1, line - 3), line + 3 }
  require("leap").leap {
    pattern = "\\v(%<" .. top .. "l|%>" .. bot .. "l)$",
    windows = { vim.fn.win_getid() },
    opts = { safe_labels = "" },
  }
end)
