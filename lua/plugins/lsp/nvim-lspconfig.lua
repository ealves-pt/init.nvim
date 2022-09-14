-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
	return
end

---Common perf related flags for all the LSP servers
local flags = {
	allow_incremental_sync = true,
	debounce_text_changes = 200,
}

-- Configuring native diagnostics
vim.diagnostic.config({
	virtual_text = {
		source = "always",
	},
	float = {
		source = "always",
	},
})

local U = require("plugins.lsp.utils")

---Common `on_attach` function for LSP servers
local function on_attach(client, bufnr)
	U.disable_formatting(client)
	U.mappings(bufnr)
end

-- List of the LSP server that don't need special configuration
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
	"bashls", -- Bash
	"cssls", -- CSS
	"gopls", -- Go
	"html", -- HTML
	"intelephense", -- PHP
	"jsonls", -- JSON
	"tsserver", -- JavaScript/TypeScript
	"yamlls", -- YAML
}

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		flags = flags,
		capabilities = U.capabilities(),
		on_attach = on_attach,
	})
end

-- Lua
lspconfig.sumneko_lua.setup({
	flags = flags,
	capabilities = U.capabilities(),
	on_attach = on_attach,
	library = {
		vimruntime = true,
		types = true,
		plugins = false,
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.fn.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim", "use", "describe", "it", "assert", "before_each", "after_each" },
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
