local map = require("utils.keymap")
local types = require("luasnip.util.types")
local luasnip = require("luasnip")

luasnip.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "DiffAdd" } },
			},
		},
		[types.insertNode] = {
			active = {
				virt_text = { { "●", "DiffDelete" } },
			},
		},
	},
})

-- Loading any vscode snippets from plugins
require("luasnip.loaders.from_vscode").lazy_load()

-- Allow jsx and tsx to use js snippets
luasnip.filetype_extend("javascript", { "javascriptreact", "typescriptreact" })

-- Mappins to move around inside snippets
map({ "i", "s" }, "<C-j>", '<CMD>lua require("luasnip").jump(1)<CR>')
map({ "i", "s" }, "<C-k>", '<CMD>lua require("luasnip").jump(-1)<CR>')
