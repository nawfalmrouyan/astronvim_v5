vim.keymap.set("n", "<leader>h", function() Snacks.dashboard() end, { desc = "Snacks dashboard" })
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Snacks Explorer" })
-- clear windows newline
vim.keymap.set("n", "<leader>fn", function() vim.cmd ":%s/\r//g" end, { desc = "Clear windows newline" })

vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- better up/down
-- If there is no count (v:count == 0), pressing j will execute gj
-- Useful when dealing with wrapped lines in the buffer.
-- If there is a count (v:count != 0), pressing j will execute j.
-- For example, if you press 3j to move down three lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- use gh to move to the beginning of the line in normal mode
-- use gl to move to the end of the line in normal mode
vim.keymap.set("n", "gh", "^", { desc = "Go to the beginning of the line" })
vim.keymap.set("n", "gl", "$", { desc = "go to the end of the line" })
vim.keymap.set("v", "gh", "^", { desc = "Go to the beginning of the line in visual mode" })
vim.keymap.set("v", "gl", "$", { desc = "Go to the end of the line in visual mode" })

-- Make the file you run the command on, executable, so you don't have to go out to the command line
-- Had to include quotes around "%" because there are some apple dirs that contain spaces, like iCloud
vim.keymap.set("n", "<leader>fx", '<cmd>!chmod +x "%"<CR>', { silent = true, desc = "Make file executable" })
vim.keymap.set("n", "<leader>fX", '<cmd>!chmod -x "%"<CR>', { silent = true, desc = "Remove executable flag" })

vim.keymap.set("n", "<leader>mhi", function()
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd [[:g/\(^$\n\s*#\+\s.*\n^$\)/ .+1 s/^#\+\s/#&/c]]
end, { desc = "Increase .md headings with confirmation" })

vim.keymap.set("n", "<leader>mhI", function()
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd [[:g/\(^$\n\s*#\+\s.*\n^$\)/ .+1 s/^#\+\s/#&/]]
end, { desc = "Increase .md headings without confirmation" })

-- These are similar, but instead of adding an # they remove it
vim.keymap.set("n", "<leader>mhd", function()
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd [[:g/^\s*#\{2,}\s/ s/^#\(#\+\s.*\)/\1/c]]
end, { desc = "Decrease .md headings with confirmation" })

vim.keymap.set("n", "<leader>mhD", function()
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd [[:g/^\s*#\{2,}\s/ s/^#\(#\+\s.*\)/\1/]]
end, { desc = "Decrease .md headings without confirmation" })

vim.keymap.set("n", "ycc", '"yy" . v:count1 . "gcc\']p"', { remap = true, expr = true }) -- duplicate and comment
vim.keymap.set("x", "/", "<Esc>/\\%V")                                                   -- search within visual selection - this is magic

-- paragraphy
vim.keymap.set(
  "n",
  "<leader>yp",
  [[:%s/\(\(\S\+\s\+\)\{70}\)/\1\r\r/g<CR>]],
  { desc = "Insert newline after every 70 words" }
)

-- https://www.reddit.com/r/neovim/comments/1s9q0pi/incremental_selection_in_neovim_012/
-- incremental selection treesitter/lsp
vim.keymap.set({ "n", "x", "o" }, "<M-o>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

vim.keymap.set({ "n", "x", "o" }, "<M-i>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })
