vim.keymap.set("n", "<leader>h", function() Snacks.dashboard() end, { desc = "Snacks dashboard" })
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

-- Paste images
-- I use a Ctrl keymap so that I can paste images in insert mode
-- I tried using <C-v> but duh, that's used for visual block mode
-- so don't do it
vim.keymap.set({ "i" }, "<C-a>", function()
  -- Call the paste_image function from the Lua API
  -- Using the plugin's Lua API (require("img-clip").paste_image()) instead of the
  -- PasteImage command because the Lua API returns a boolean value indicating
  -- whether an image was pasted successfully or not.
  -- The PasteImage command does not
  -- https://github.com/HakonHarnes/img-clip.nvim/blob/main/README.md#api
  local pasted_image = require("img-clip").paste_image()
  if pasted_image then
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd "update"
    print "Image pasted and file saved"
    -- Only if updated I'll refresh the images by clearing them first
    -- I'm using [[ ]] to escape the special characters in a command
    vim.cmd [[lua require("image").clear()]]
    -- Reloads the file to reflect the changes
    vim.cmd "edit!"
    -- Switch back to command mode
    vim.cmd "stopinsert"
  else
    print "No image pasted. File not updated."
  end
end, { desc = "Paste image from system clipboard" })

-- Open image under cursor in the Preview app
vim.keymap.set("n", "<leader>ao", function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = "%[.-%]%((.-)%)"
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end

  -- Get the image path
  local image_path = get_image_path()

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      print "URL image, use 'gx' to open it in the default browser."
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand "%:p:h"
      local absolute_image_path = current_file_path .. "/" .. image_path

      -- Construct command to open image in Preview
      local command = "feh " .. vim.fn.shellescape(absolute_image_path)
      -- Execute the command
      local success = os.execute(command)

      if success then
        print("Opened image in Preview: " .. absolute_image_path)
      else
        print("Failed to open image in Preview: " .. absolute_image_path)
      end
    end
  else
    print "No image found under the cursor"
  end
end, { desc = "Open image under cursor in Preview" })

-- Delete image file under cursor using trash app
vim.keymap.set("n", "<leader>ad", function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = "%[.-%]%((.-)%)"
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end

  -- Get the image path
  local image_path = get_image_path()

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      vim.api.nvim_echo({
        { "URL image cannot be deleted from disk.", "WarningMsg" },
      }, false, {})
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand "%:p:h"
      local absolute_image_path = current_file_path .. "/" .. image_path

      -- Check if trash utility is installed
      if vim.fn.executable "trash" == 0 then
        vim.api.nvim_echo({
          { "- Trash utility not installed. Make sure to install it first\n", "ErrorMsg" },
        }, false, {})
        return
      end

      -- Prompt for confirmation before deleting the image
      vim.ui.input({
        prompt = "Delete image file? (y/n) ",
      }, function(input)
        if input == "y" or input == "Y" then
          -- Delete the image file using trash app
          local success, _ = pcall(function() vim.fn.system { "trash", vim.fn.fnameescape(absolute_image_path) } end)

          if success then
            vim.api.nvim_echo({
              { "Image file deleted from disk:\n", "Normal" },
              { absolute_image_path, "Normal" },
            }, false, {})
            -- I'll refresh the images, but will clear them first
            -- I'm using [[ ]] to escape the special characters in a command
            vim.cmd [[lua require("image").clear()]]
            -- Reloads the file to reflect the changes
            vim.cmd "edit!"
          else
            vim.api.nvim_echo({
              { "Failed to delete image file:\n", "ErrorMsg" },
              { absolute_image_path, "ErrorMsg" },
            }, false, {})
          end
        else
          vim.api.nvim_echo({
            { "Image deletion canceled.", "Normal" },
          }, false, {})
        end
      end)
    end
  else
    vim.api.nvim_echo({
      { "No image found under the cursor", "WarningMsg" },
    }, false, {})
  end
end, { desc = "Delete image file under cursor" })

-- Refresh the images in the current buffer
-- Useful if you delete an actual image file and want to see the changes
-- without having to re-open neovim
vim.keymap.set("n", "<leader>ar", function()
  -- First I clear the images
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd [[lua require("image").clear()]]
  -- Reloads the file to reflect the changes
  vim.cmd "edit!"
  print "Images refreshed"
end, { desc = "Refresh images" })

-- Set up a keymap to clear all images in the current buffer
vim.keymap.set("n", "<leader>ac", function()
  -- This is the command that clears the images
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd [[lua require("image").clear()]]
  print "Images cleared"
end, { desc = "Clear images" })

-- - I have several `.md` documents that do not follow markdown guidelines
-- - There are some old ones that have more than one H1 heading in them, so when I
--   open one of those old documents, I want to add one more `#` to each heading
-- - The command below does this only for:
--   - Lines that have a newline `above` AND `below`
--   - Lines that have a space after the `##` to avoid `#!/bin/bash`
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

-- Smart delete
local function smart_delete(key)
  local l = vim.api.nvim_win_get_cursor(0)[1] -- Get the current cursor line number
  local line = vim.api.nvim_buf_get_lines(0, l - 1, l, true)[1] -- Get the content of the current line
  return (line:match "^%s*$" and '"_' or "") .. key -- If the line is empty or contains only whitespace, use the black hole register
end

local keys = { "d", "dd", "x", "c", "s", "C", "S", "X" } -- Define a list of keys to apply the smart delete functionality

-- Set keymaps for both normal and visual modes
for _, key in pairs(keys) do
  vim.keymap.set(
    { "n", "v" },
    key,
    function() return smart_delete(key) end,
    { noremap = true, expr = true, desc = "Smart delete" }
  )
end
