-- Plugin: lualine.nvim
-- url: https://github.com/nvim-lualine/lualine.nvim

require("lualine").setup({
  options = {
    theme = "catppuccin",
  },
  extensions = { "quickfix", "fugitive", "nvim-tree" },
})
