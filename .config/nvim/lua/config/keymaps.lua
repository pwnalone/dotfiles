----------------------------------------------------------------------------------------------------

local map = function(mode, lhs, rhs, opts)
  local base = { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base, opts or {}))
end

local del = function(mode, lhs, buffer)
  vim.keymap.del(mode, lhs, { buffer = buffer })
end

----------------------------------------------------------------------------------------------------

-- Remove a few of LazyVim's default keymaps.

-- Move text up/down with proper indentation.
del({ "n", "i", "v" }, "<M-j>")
del({ "n", "i", "v" }, "<M-k>")

-- Open horizontal/vertical splits.
del("n", "<leader>-")
del("n", "<leader>|")

-- Switch windows.
del("n", "<C-h>")
del("n", "<C-j>")
del("n", "<C-k>")
del("n", "<C-l>")

-- Resize windows.
del("n", "<C-Left>")
del("n", "<C-Down>")
del("n", "<C-Up>")
del("n", "<C-Right>")

----------------------------------------------------------------------------------------------------

-- Enter command mode more easily.
map({ "n", "x" }, ";", ":", { desc = "Enter Command Mode", silent = false })

-- Move buffers left/right in the bufferline.
map("n", "<C-h>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })
map("n", "<C-l>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })

-- Move text up/down with proper indentation.
map("n", "<C-j>", "<Cmd>execute 'move .+' . v:count1<CR>==", { desc = "Move Down" })
map("n", "<C-k>", "<Cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move Up" })
map("x", "<C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move Down" })
map("x", "<C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move Up" })

-- Increment/decrement numbers, letters, etc.
map({ "n", "x" }, "+", "<C-a>", { desc = "Increment Selection or Item Under the Cursor", remap = true })
map({ "n", "x" }, "-", "<C-x>", { desc = "Decrement Selection or Item Under the Cursor", remap = true })
map("x", "g+", "g<C-a>", { desc = "Progressively Increment Selection", remap = true })
map("x", "g-", "g<C-x>", { desc = "Progressively Decrement Selection", remap = true })

-- Yank text and sync to clipboard.
map({ "n", "x" }, "Y", [["+y]], { desc = "Yank Text and Sync to Clipboard", remap = true })
map({ "n", "x" }, "YY", [["+yy]], { desc = "which_key_ignore", remap = true })

-- Open horizontal/vertical splits.
map("n", [[<leader>\]], "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", [[<leader>|]], "<C-W>v", { desc = "Split Window Right", remap = true })

-- Switch windows.
map({ "n", "i", "t" }, "<M-h>", function()
  require("smart-splits").move_cursor_left()
end, { desc = "Go to Left Window" })
map({ "n", "i", "t" }, "<M-j>", function()
  require("smart-splits").move_cursor_down()
end, { desc = "Go to Lower Window" })
map({ "n", "i", "t" }, "<M-k>", function()
  require("smart-splits").move_cursor_up()
end, { desc = "Go to Upper Window" })
map({ "n", "i", "t" }, "<M-l>", function()
  require("smart-splits").move_cursor_right()
end, { desc = "Go to Right Window" })

-- BUG: Move to previous pane is broken in smart-splits.nvim.
--
-- map({ "n", "i", "t" }, "<M-;>", function()
--   require("smart-splits").move_cursor_previous()
-- end, { desc = "Go to Previous Window" })

-- Resize windows.
map({ "n", "i", "t" }, "<M-H>", function()
  require("smart-splits").resize_left()
end, { desc = "Resize Window Leftwards" })
map({ "n", "i", "t" }, "<M-J>", function()
  require("smart-splits").resize_down()
end, { desc = "Resize Window Upwards" })
map({ "n", "i", "t" }, "<M-K>", function()
  require("smart-splits").resize_up()
end, { desc = "Resize Window Downwards" })
map({ "n", "i", "t" }, "<M-L>", function()
  require("smart-splits").resize_right()
end, { desc = "Resize Window Rightwards" })

-- Swap buffers between windows.
map("n", "<M-C-h>", function()
  require("smart-splits").swap_buf_left()
end, { desc = "Swap with Left Window" })
map("n", "<M-C-j>", function()
  require("smart-splits").swap_buf_down()
end, { desc = "Swap with Lower Window" })
map("n", "<M-C-k>", function()
  require("smart-splits").swap_buf_up()
end, { desc = "Swap with Upper Window" })
map("n", "<M-C-l>", function()
  require("smart-splits").swap_buf_right()
end, { desc = "Swap with Right Window" })

----------------------------------------------------------------------------------------------------
