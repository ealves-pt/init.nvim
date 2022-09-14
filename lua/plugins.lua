-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install packer
-- See: https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- See: https://github.com/wbthomason/packer.nvim#quickstart
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Install plugins
return packer.startup({
	function(use)
		-- packer can manage itself
		use("wbthomason/packer.nvim")

		-- common dependency of several plugins
		use("nvim-lua/plenary.nvim")

		-- Nord theme
		use({
			"rmehri01/onenord.nvim",
			config = [[require('plugins.onenord-nvim')]],
		})

		use({
			"kyazdani42/nvim-web-devicons",
			config = [[require('nvim-web-devicons').setup()]],
		})

		-- File explorer
		use({
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
			config = [[require('plugins.nvim-tree')]],
		})

		-- Status Line
		use({
			"nvim-lualine/lualine.nvim",
			config = [[require('plugins.lualine')]],
			requires = "kyazdani42/nvim-web-devicons",
		})

		-- Show diagnostics
		use({
			"folke/trouble.nvim",
			after = "nvim-web-devicons",
			config = [[require('plugins.trouble')]],
		})

		-- Search
		use({
			"nvim-telescope/telescope.nvim",
			config = [[require('plugins.telescope')]],
			requires = {
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					run = "make",
				},
				"nvim-telescope/telescope-ui-select.nvim",
				"nvim-telescope/telescope-dap.nvim",
				"nvim-telescope/telescope-symbols.nvim",
			},
		})

		-- Treesitter interface (better highlights)
		use({
			{
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
				config = [[require('plugins.nvim-treesitter')]],
			},
			{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
			{ "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
		})

		-- Manage external LSP, DAP, Linters, and Formatters
		use({
			"williamboman/mason.nvim",
			config = [[require('plugins.lsp.mason')]],
			requires = "williamboman/mason-lspconfig.nvim",
		})

		-- DAP
		use({
			"mfussenegger/nvim-dap",
			cmd = { "BreakpointToggle", "Debug", "DapREPL" },
			module = "dap",
		})

		-- LSP
		use({
			{
				"neovim/nvim-lspconfig",
				config = [[require('plugins.lsp.nvim-lspconfig')]],
				requires = "hrsh7th/cmp-nvim-lsp",
			},
			{ -- nvim-lspconfig progress status
				"j-hui/fidget.nvim",
				config = [[require('fidget').setup()]],
			},
		})

		-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = [[require('plugins.lsp.null-ls')]],
		})

		-- Snippets
		use({
			{
				"L3MON4D3/LuaSnip",
				config = [[require('plugins.lsp.luasnip')]],
			},
			"rafamadriz/friendly-snippets",
		})

		-- Autocomplete
		use({
			"hrsh7th/nvim-cmp",
			config = [[require('plugins.lsp.nvim-cmp')]],
			requires = {
				{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
				{ "hrsh7th/cmp-path", after = "nvim-cmp" },
				{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
				{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
				{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
				{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			},
		})

		-- Git
		use("tpope/vim-fugitive") -- Git integration
		use({ -- Git decorations
			"lewis6991/gitsigns.nvim",
			config = [[require('gitsigns').setup()]],
		})

		-- Functionalities
		use("github/copilot.vim") -- GitHub Copilot
		use("tpope/vim-commentary") -- Comment functionalities
		use("tpope/vim-surround") -- Surrounding stuff
		use({ -- Automatically pair symbols
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = [[require('plugins.nvim-autopairs')]],
		})
		use("gpanders/editorconfig.nvim") -- EditorConfig support
		use({ -- Markdown preview
			"iamcco/markdown-preview.nvim",
			ft = { "markdown", "vim-use" },
			run = [[fn['mkdp#util#install']()]],
		})

		-- Run tests
		use({
			"vim-test/vim-test",
			config = [[require('plugins.vim-test')]],
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {},
})
