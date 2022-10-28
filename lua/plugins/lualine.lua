-- Plugin: lualine.nvim
-- url: https://github.com/nvim-lualine/lualine.nvim

require("lualine").setup({
  options = {
    theme = "onenord",
  },
  extensions = { "quickfix", "fugitive", "nvim-tree" },
})
