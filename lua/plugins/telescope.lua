-- Plugin: telescope.nvim
-- url: https://github.com/nvim-telescope/telescope.nvim

local map = require("utils.keymap")
local actions = require("telescope.actions")
local builtins = require("telescope.builtin")

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

telescope.setup({
  defaults = {
    sorting_strategy = "ascending", -- results are displayed top to bottom
    layout_config = {
      prompt_position = "top", -- prompt is at the top
    },
    mappings = {
      i = {
        ["<C-b>d"] = actions.delete_buffer,
        ["<ESC>"] = actions.close,
      },
      n = {
        ["<C-b>d"] = actions.delete_buffer,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("dap")

-- Find files
map("n", "<leader><leader>", "<leader>ff", { remap = true })
map("n", "<leader>ff", function()
  local ok = pcall(builtins.git_files, { show_untracked = true })
  if not ok then
    builtins.find_files()
  end
end)

-- Search for string
map("n", "<leader>fg", function()
  builtins.live_grep()
end)

-- Find in active buffers
map("n", "<leader>fb", function()
  builtins.buffers({ sort_lastused = true })
end)

-- Find help tags
map("n", "<leader>fht", function()
  builtins.help_tags()
end)
