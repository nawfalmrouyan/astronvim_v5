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
        -- (no user input).
        local vim_opts = require("leap").opts.vim_opts
        vim_opts["wo.conceallevel"] = nil

        require("leap").leap {
          pattern = vim.fn.getreg "/", -- last search pattern
          target_windows = { vim.fn.win_getid() },
          opts = { safe_labels = "", labels = labels, vim_opts = vim_opts },
        }
      end)
    end
  end,
})

do
  -- Returns an argument table for `leap()`, tailored for f/t-motions.
  local function as_ft(key_specific_args)
    local common_args = {
      inputlen = 1,
      inclusive_op = true,
      -- To limit search scope to the current line:
      -- pattern = function (pat) return '\\%.l'..pat end,
      opts = {
        labels = "", -- force autojump
        safe_labels = vim.fn.mode(1):match "o" and "" or nil, -- [1]
        case_sensitive = true, -- [2]
      },
    }
    return vim.tbl_deep_extend("keep", common_args, key_specific_args)
  end

  local clever = require("leap.user").with_traversal_keys -- [3]
  local clever_f = clever("f", "F")
  local clever_t = clever("t", "T")

  for key, args in pairs {
    f = { opts = clever_f },
    F = { backward = true, opts = clever_f },
    t = { offset = -1, opts = clever_t },
    T = { backward = true, offset = 1, opts = clever_t },
  } do
    vim.keymap.set({ "n", "x", "o" }, key, function() require("leap").leap(as_ft(args)) end)
  end
end
