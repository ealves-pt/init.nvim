local map = require("utils.keymap")

local U = {}

local fmt_group = vim.api.nvim_create_augroup("LspFormatter", { clear = true })

-- Format on save for LSP servers that implement formatting
function U.fmt_on_save(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = fmt_group,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.formatting({
					timeout_ms = 3000,
					buffer = bufnr,
				})
			end,
		})
	end
end

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
function U.capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
end

---Disable formatting for servers | Handled by null-ls
---@see https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
function U.disable_formatting(client)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = true
end

---Creates LSP mappings
function U.mappings(bufnr)
	local opts = { buffer = bufnr }

	map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

	map("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	map("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	map("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

return U
