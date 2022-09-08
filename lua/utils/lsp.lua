local map = require('utils.keymap')

local U = {}

---Disable formatting for servers | Handled by null-ls
---@see https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
function U.client_disable_formatting(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
end

---Creates LSP mappings
function U.buf_mappings(bufnr)
    local opts = { buffer = bufnr }

    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    -- map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

return U
