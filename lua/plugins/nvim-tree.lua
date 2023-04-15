-- Plugin: nvim-tree
-- url: https://github.com/kyazdani42/nvim-tree.lua

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local map = require("utils.keymap")
map("n", "<C-n>", ":NvimTreeToggle<CR>")       -- open/close
map("n", "<leader>n", ":NvimTreeFindFile<CR>") -- search file

-- Call setup:
-- Each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`)
nvim_tree.setup({
  hijack_cursor = true,
  update_focused_file = {
    enable = true,              -- focus the current buffer on the tree
  },
  remove_keymaps = { "<Tab>" }, -- remove keymaps
  view = {
    float = {
      enable = true, -- menu will be displayed in a floating window
    },
  },
  git = {
    ignore = false, -- show git ignored files
  },
  renderer = {
    root_folder_label = false, -- prevent root folder from being displayed
    add_trailing = true,       -- append / to folder names
    group_empty = true,        -- compact folders
  },
})
