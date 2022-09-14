local g = vim.g
local map = require("utils.keymap")

-- essentials
g.mapleader = " "
g.maplocalleader = " "
map("n", "<leader>s", ":w<CR>")
map("n", "<leader>r", ":so %<CR>")
map("", "<esq>", "<esc>:noh<CR><esc>")
-- tab circular window navigation
map("n", "<Tab>", ":tabnext<CR>")
map("n", "<S-Tab>", ":tabprevious<CR>")
-- splits
map("n", "<M-x>", "<C-w>s")
map("n", "<M-v>", "<C-w>v")
-- switch between splits using meta + {h,j,k,l}
map("n", "<M-h>", "<C-w>h")
map("n", "<M-j>", "<C-w>j")
map("n", "<M-k>", "<C-w>k")
map("n", "<M-l>", "<C-w>l")
-- resize splits
map("n", "<M-Up>", "<C-w>+")
map("n", "<M-Down>", "<C-w>-")
map("n", "<M-Left>", "<C-w><")
map("n", "<M-Right>", "<C-w>>")
-- escaping
map("i", "jk", "<esc>")
map("x", "jk", "<esc>")
map("c", "jk", "<esc>")
-- moving lines
map("n", "<C-k>", ":move-2<CR>")
map("n", "<C-j>", ":move+<CR>")
map("n", "<C-h>", "<<")
map("n", "<C-l>", ">>")
map("x", "<C-k>", ":move-2<CR>gv")
map("x", "<C-j>", ":move'>+<CR>gv")
map("x", "<C-h>", "<gv")
map("x", "<C-l>", ">gv")
