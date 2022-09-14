-- Plugin: vim-test
-- url: https://github.com/vim-test/vim-test

local g = vim.g

-- see, https://github.com/vim-test/vim-test#strategies
g["test#strategy"] = "neovim"

local map = require("utils.keymap")

-- see, https://github.com/vim-test/vim-test#setup
map("n", "<leader>tn", ":TestNearest<CR>")
map("n", "<leader>tf", ":TestFile<CR>")
map("n", "<leader>ta", ":TestSuite<CR>")
map("n", "<leader>tl", ":TestLast<CR>")
map("n", "<leader>tg", ":TestVisit<CR>")
