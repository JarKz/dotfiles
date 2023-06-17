local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorscheme
	{
		"sainnhe/sonokai",
		config = function()
			require("colorscheme")
		end,
	},
	-- using macos keymap instead qwerty
	{ "shvechikov/vim-keymap-russian-jcukenmac" },
	{ "wakatime/vim-wakatime" },
	{ "nvim-lua/plenary.nvim" },

	-- LSP
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("ls.mason-lspconfig")
			end,
		},
		config = function()
			require("ls.mason")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("ls.config")
			require("ls.highlights")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("ls.null-ls")
		end,
	},

	-- Extensions for lsp
	{ "mfussenegger/nvim-jdtls" },

	-- Additional LSP functionality
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	-- DAP
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("lsp-dap.init")
		end,
	},
	{
		"folke/neodev.nvim",
		ft = "lua",
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
		end,
	},

	-- AUTOCMP
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-cmdline", -- command line
			"hrsh7th/cmp-omni",
			"hrsh7th/cmp-buffer", -- buffer completions
			"hrsh7th/cmp-nvim-lua", -- nvim config completions
			"hrsh7th/cmp-nvim-lsp", -- lsp completions
			"hrsh7th/cmp-path", -- file path completions
			"hrsh7th/cmp-nvim-lsp-signature-help", -- function/class sugnature helping
			"saadparwaiz1/cmp_luasnip", -- snippets completions
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind-nvim",
			{
				"tzachar/cmp-tabnine",
				build = "./install.sh",
				dependencies = "hrsh7th/nvim-cmp",
			},
		},
		config = function()
			require("autocmp.init")
		end,
	},
	{ "windwp/nvim-ts-autotag" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- WINDOW PLUGINS
	-- Telescope for finding something
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
		},
		config = function()
			require("window-plugins.telescope")
		end,
	},

	-- FZF
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("window-plugins.fzf")
		end,
	},

	-- Overriding vim.ui.select and vim.ui.insert
	{
		"stevearc/dressing.nvim",
		config = function()
			require("window-plugins.dressing")
		end,
	},

	-- File tree in bottom screen
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("window-plugins.filetree")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("window-plugins.toggleterm")
		end,
	},

	-- Dashboard
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("window-plugins.dashboard")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- {
	-- 	"glepnir/dbsession.nvim",
	-- 	cmd = { "SessionSave", "SessionDelete", "SessionLoad" },
	-- 	config = function()
	-- 		require("dbsession").setup({})
	-- 	end,
	-- },

	-- Change default vim.notify
	{
		"rcarriga/nvim-notify",
		config = function()
			require("window-plugins.notify")
		end,
	},

	-- Display LS status as float window
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("window-plugins.fidget")
		end,
	},
	{
		"glepnir/galaxyline.nvim",
		branch = "main",
		config = function()
			require("window-plugins.statusline")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons", "sainnhe/sonokai", opt = true },
	},

	-- Float note
	{
		"JellyApple102/flote.nvim",
		config = function()
			require("window-plugins.flote")
		end,
	},

	{
		"ellisonleao/glow.nvim",
		ft = "markdown",
		config = function()
			local glow = require("glow")

			glow.setup({
				glow_path = "/opt/homebrew/bin/glow",
				-- If executable not found and glow will install to specific path.
				-- If you don't have glow then uncomment code below and rename
				-- installation path
				-- install_path = "~/path/to/install/bin",
				border = require("window-plugins.window-config").border,
				pager = false,
				width = 100,
				height = 120,
			})
		end,
	},

	-- ADDITIONAL FUNCTIONALITY
	{
		"folke/which-key.nvim",
		config = function()
			require("additional-functionality.mapping")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("additional-functionality.commentary")
		end,
	},
	{
		"edluffy/specs.nvim",
		config = function()
			require("additional-functionality.cursor-blinks")
		end,
	},
	{
		"booperlv/nvim-gomove",
		config = function()
			require("additional-functionality.move")
		end,
	},
	{
		"uga-rosa/translate.nvim",
		config = function()
			require("additional-functionality.translate")
		end,
	},
	{
		"wintermute-cell/gitignore.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"chrisgrieser/nvim-spider",
		config = function()
			require("additional-functionality.spider")
		end,
	},

	-- Pretty folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("additional-functionality.folding")
		end,
	},

	-- ({ "roobert/search-replace.nvim" })
	{
		"JarKz/search-replace-additional-configuration.nvim",
		branch = "dev",
		config = function()
			require("additional-functionality.search-replace")
		end,
	},

	-- SYNTAX HIGHLIHGT
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("syntax.treesitter")
		end,
	},
	-- Highlight similar or logical keyword pairs (e.g. for { -> } or break -> while)
	{ "RRethy/vim-illuminate" },

	-- AUTONOMOUS
	{
		"Pocco81/auto-save.nvim",
		-- for avoid duplicate of message
		branch = "dev",
		config = function()
			require("autonomous.autosave")
		end,
	},
}, {
	ui = {
		border = require("window-plugins.window-config").border,
	},
})