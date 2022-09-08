-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

---Common perf related flags for all the LSP servers
local flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 200,
}

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Configuring native diagnostics
vim.diagnostic.config({
    virtual_text = {
        source = 'always',
    },
    float = {
        source = 'always',
    },
})

local lsp = require('utils.lsp')

---Common `on_attach` function for LSP servers
local function on_attach(client, bufnr)
    lsp.client_disable_formatting(client)
    lsp.buf_mappings(bufnr)
end

-- List of the LSP server that don't need special configuration
-- See: jhttps://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
    'bashls',       -- Bash
    'cssls',        -- CSS
    'gopls',        -- Go
    'html',         -- HTML
    'intelephense', -- PHP
    'jsonls',       -- Json
    'tsserver',     -- JavaScript/TypeScript
    'yamlls',       -- YAML
}

for _, server in ipairs(servers) do
    lspconfig[server].setup({
        flags = flags,
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

-- Lua
lspconfig.sumneko_lua.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            completion = {
                enable = true,
                showWord = 'Disable',
                -- keywordSnippet = 'Disable',
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = { os.getenv('VIMRUNTIME') },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
