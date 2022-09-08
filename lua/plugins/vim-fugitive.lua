-- Plugin: vim-fugitive
-- url: https://github.com/tpope/vim-fugitive

local map = require('utils.keymap')

map('n', '<leader>gs', ':Git<CR>')
map('n', '<leader>gl', ':Commits<CR>')
map('n', '<leader>gd', ':Gdiffsplit<CR>')
map('n', '<leader>gb', ':Git blame<CR>')
