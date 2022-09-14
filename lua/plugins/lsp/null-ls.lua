-- Plugin: null-ls.nvim
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim

local U = require("plugins.lsp.utils")

local nls = require("null-ls")
local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local codeactions = nls.builtins.code_actions

-- Configuring null-ls
nls.setup({
	sources = {
		----------------
		-- FORMATTING --
		----------------
		formatting.buf, -- Proto / Buf
		formatting.gofmt, -- Go
		formatting.goimports, -- Go
		formatting.shfmt.with({ -- Shell
			extra_args = { "-i", 4, "-ci", "-sr" },
		}),
		formatting.stylua, -- Lua
		-----------------
		-- DIAGNOSTICS --
		-----------------
		diagnostics.buf, -- Proto / Buf
		diagnostics.golangci_lint, -- Go
		diagnostics.luacheck.with({ -- Lua
			extra_args = { "--globals", "vim", "--std", "luajit" },
		}),
		diagnostics.markdownlint, -- Markdown
		diagnostics.shellcheck, -- Shell
		------------------
		-- CODE ACTIONS --
		------------------
		codeactions.shellcheck, -- Shell
	},
	on_attach = function(client, bufnr)
		U.fmt_on_save(client, bufnr)
		U.mappings(bufnr)
	end,
})
