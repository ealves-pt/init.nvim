-- Plugin: trouble.nvim
-- url: https://github.com/folke/trouble.nvim

local trouble_status_ok, trouble = pcall(require, 'trouble')
if not trouble_status_ok then
  return
end

trouble.setup({
  mode = 'document_diagnostics', -- show only document diagnostics (pressing 'm' will toggle between document and workspace)
  use_diagnostic_signs = true,   -- use the signs defined in your lsp client
})

local map = require('utils.keymap')

map('n', '<leader>xt', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xw', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>')
map('n', '<leader>xd', '<cmd>TroubleToggle lsp_document_diagnostics<cr>')
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>')
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
-- map('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>')
