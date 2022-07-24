local misc = require('plugins.misc')
local packer_bootstrap = misc.first_install_packer()

require('packer').init(misc.packer_init_config)

-- local lazy_event_enter_file = {'BufRead','BufNewFile'}

-- just install
local function ins(use)
	use 'wbthomason/packer.nvim'
	use 'famiu/bufdelete.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'RRethy/vim-illuminate'
	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	use 'kyazdani42/nvim-web-devicons'
	use 'nvim-lua/plenary.nvim'
	use 'lewis6991/impatient.nvim'
	use 'rafamadriz/friendly-snippets'
end


-- install then config
local function ins_cfg(use)
	-- plugin -> config function
	local pl_cf = {
		['folke/tokyonight.nvim'] = misc.tokyonight,
		['nvim-lualine/lualine.nvim'] = misc.lualine,
		['rmagatti/auto-session'] = misc.auto_session,
		['ray-x/lsp_signature.nvim'] = misc.lsp_signature,
		----------------------
		['windwp/nvim-autopairs'] = function() require('nvim-autopairs').setup{} end,
		['folke/trouble.nvim'] = function() require('trouble').setup{} end,
		['mrjones2014/smart-splits.nvim'] = function() require('smart-splits').setup{} end,
		['folke/todo-comments.nvim'] = function() require('todo-comments').setup{} end,
		['theHamsta/nvim-dap-virtual-text'] = function() require('nvim-dap-virtual-text').setup{} end,
		['rmagatti/session-lens'] = function() require('session-lens').setup{} end,
		['Weissle/persistent-breakpoints.nvim'] = function() require('persistent-breakpoints').setup{} end,
		['numToStr/Comment.nvim'] = function() require('Comment').setup{} end,
		-------------------------------
		['rcarriga/nvim-notify'] = require('plugins.notify'),
		['kyazdani42/nvim-tree.lua'] = require('plugins.nvim-tree'),
		['rcarriga/nvim-dap-ui'] = require('plugins.dap-ui'),
		['hrsh7th/nvim-cmp'] = require('plugins.nvim-cmp'),
		['mfussenegger/nvim-dap'] = require('plugins.dap'),
		['williamboman/nvim-lsp-installer'] = require('plugins.lspinstaller'),
	}

	for plugin_name,config_function in pairs(pl_cf) do
		use{
			plugin_name,
			config = config_function
		}
	end
end
local load_plugins_function = function(use)

	ins(use)
	ins_cfg(use)

	use {
		'nvim-telescope/telescope.nvim',
		cmd = "Telescope",
		branch = '0.1.x',
		requires = {},
		config = function ()
			require('plugins.telescope')()
		end
	}

	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
		after = 'telescope.nvim',
		config = function ()
			require('telescope').load_extension('fzf')
		end
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('plugins.treesitter')()
		end
	}


	use {
		'neovim/nvim-lspconfig',
		after = "nvim-lsp-installer",
		config = function()
			require('plugins.lspconfig')()
		end
	}


	local cmp_plugin_list = {
		'hrsh7th/cmp-nvim-lsp',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-nvim-lua',
		'ray-x/cmp-treesitter'
	}

	for _,pl_name in ipairs(cmp_plugin_list) do
		use {
			pl_name,
			after = 'nvim-cmp'
		}
	end
	use{
		'L3MON4D3/LuaSnip',
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end
	}


	use {
		'nvim-telescope/telescope-dap.nvim',
		after = 'telescope.nvim',
		config = function ()
			require('telescope').load_extension('dap')
		end
	}


	use {
		'akinsho/bufferline.nvim',
		tag = "v2.*",
		requires = 'kyazdani42/nvim-web-devicons',
		config = function ()
			require('bufferline').setup{}
		end
	}

	use {
		'williamboman/mason.nvim',
		branch = "alpha",
		config = function ()
			require('mason').setup{}
		end
	}


	use {
		"danymat/neogen",
		config = function()
			require('neogen').setup {
				snippet_engine = 'luasnip'
			}
		end,
	}

	use {
		"akinsho/toggleterm.nvim",
		tag = 'v2.*',
		config = function()
			require("toggleterm").setup()
		end
	}

	use {
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			require'hop'.setup{}
		end
	}

	use {
		'lewis6991/gitsigns.nvim',
		tag = 'release',
		config = function()
			require('plugins.gitsigns')()
		end


	}
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end

require('packer').startup({load_plugins_function,config = misc.packer_config})
