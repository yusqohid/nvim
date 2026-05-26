require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Editor
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write Buffer" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd> qa! <cr>")
map("n", "<leader>a", "<cmd>e $MYVIMRC<CR>", { desc = "Edit Config File" })
map("n", "<leader>R", "<cmd> restart <CR>")
map("n", "<leader>rs", ":source $MYVIMRC <CR>")
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", {
  desc = "Change Directory to current file"
})

-- Oil & Lazy
map("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
map("n", "<leader>z", "<cmd>Lazy<CR>", { desc = "Lazy Dashboard" })
map("n", "<leader><leader>", "<cmd> Telescope find_files <cr>")

-- Move Lines (Alt + j/k)
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Resize Window
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Better Indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Find and Replace
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

-- === Clipboard ===
-- Copy
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system" })
map("n", "<leader>yy", [["+yy]], { desc = "Yank line to system" })
map("n", "<leader>Y", [["+y$]], { desc = "Yank to EOL to system" })
-- Paste
map({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system" })
map("n", "<leader>P", [["+P]], { desc = "Paste before from system" })
-- Smart Paste (Don't overwrite register)
map("x", "p", '"_dP', { desc = "Paste without overwriting" })
-- Void Delete
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void" })
map({ "n", "v" }, "<leader>dd", [["_dd]], { desc = "Delete line to void" })
vim.cmd[["command! W execute 'w !sudo tee % > /dev/null' | edit!"]]

