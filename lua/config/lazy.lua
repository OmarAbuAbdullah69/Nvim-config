local plugins = {

	-- syntax
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "42fc28ba918343ebfd5565147a42a26580579482",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
	},
	{
		"m-demare/hlargs.nvim",
		commit = "0b29317c944fb1f76503ce4540d6dceffbb5ccd2",
	},
	{ "lewis6991/gitsigns.nvim", commit = "20ad4419564d6e22b189f6738116b38871082332" },
	--file expolerer
	{
		"nvim-tree/nvim-tree.lua",
		commit = "68c67adfabfd1ce923839570507ef2e81ab8a408",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	--telescope
	{
		"nvim-telescope/telescope.nvim",
		commit = "f9e5ae3d115aa640f987b5de4af7a17358c3c5ea",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"fdschmidt93/telescope-egrepify.nvim",
		commit = "5e6fb91f52a595a0dd554c7eea022c467ff80d86",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	{ "desdic/agrolens.nvim", commit = "a2086c25c9e8fe80e07e3298f21fe2118fe9639b" },

	-- tabs and lines
	{
		"nvim-lualine/lualine.nvim",
		commit = "3946f0122255bc377d14a59b27b609fb3ab25768",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"romgrk/barbar.nvim",
		commit = "fb4369940a07dda35fa4d7f54cf4a36aa00440e6",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = true
		end,
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},

	-- fast coding
	{
		"windwp/nvim-autopairs",
		commit = "7a2c97cccd60abc559344042fefb1d5a85b3e33b",
		event = "InsertEnter",
		config = true,
	},
	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		commit = "106c4bcc053a5da783bf4a9d907b6f22485c2ea0",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-- LSP
	{ "neovim/nvim-lspconfig", commit = "2010fc6ec03e2da552b4886fceb2f7bc0fc2e9c0" },
	{ "jose-elias-alvarez/null-ls.nvim", commit = "0010ea927ab7c09ef0ce9bf28c2b573fc302f5a7" },

	-- other
	-- cool pairs manipulation
	{
		"kylechui/nvim-surround",
		commit = "fcfa7e02323d57bfacc3a141f8a74498e1522064",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- folding
	{
		"kevinhwang91/nvim-ufo",
		commit = "72d54c31079d38d8dfc5456131b1d0fb5c0264b0",
		dependencies = { "kevinhwang91/promise-async" },
	},
	--	{ "luukvbaal/statuscol.nvim"},

	-- for formatting
	{
		"stevearc/conform.nvim",
		commit = "cde4da5c1083d3527776fee69536107d98dae6c9",
		opts = {},
	},
	{ -- color picker
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup({})
		end,
	},
	{ "akinsho/toggleterm.nvim", commit = "9a88eae817ef395952e08650b3283726786fb5fb", version = "*", config = true },
	{
		"goolord/alpha-nvim",

		commit = "3979b01cb05734331c7873049001d3f2bb8477f4",
		-- dependencies = { 'echasnovski/mini.icons' },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
			-- available: devicons, mini, default is mini
			-- if provider not loaded and enabled is true, it will try to use another provider
			startify.file_icons.provider = "devicons"
			require("alpha").setup(startify.config)
		end,
	},
	{
		"pteroctopus/faster.nvim",

		config = function()
			require("faster").setup()
		end,
	},
	{
		"ggandor/leap.nvim",
		commit = "614481baedb1c11df1d88338005b3e8c15349dcf",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			require("leap").set_default_mappings()
		end,
	},
	{
		"folke/which-key.nvim",
		commit = "3aab2147e74890957785941f0c1ad87d0a44c15a",
		event = "VeryLazy",
		opts = {},
	},

	{ "numToStr/Comment.nvim", commit = "e30b7f2008e52442154b66f7c519bfd2f1e32acb" },

	{ "nat-418/boole.nvim", commit = "7b4a3dae28e3b2497747aa840439e9493cabdc49" },

	{
		"lukas-reineke/indent-blankline.nvim",
		commit = "005b56001b2cb30bfa61b7986bc50657816ba4ba",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	-- automatically check for plugin updates
	checker = { enabled = true },
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local themes = require("config.ode").get("themes")
for k, v in pairs(themes.available) do
	plugins[#plugins + 1] = v
end

-- Setup lazy.nvim
require("lazy").setup(plugins)
