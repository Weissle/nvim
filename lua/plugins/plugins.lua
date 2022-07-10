local misc = require('plugins.misc')
local packer_bootstrap = misc.first_install_packer()

require('packer').init(misc.packer_init_config)

local lazy_event_enter_file = {'BufRead','BufNewFile'}

local load_plugins_function = function(use)
	use {
		'wbthomason/packer.nvim',
	}

	use {
		'folke/tokyonight.nvim',
		config = misc.tokyonight
	}

	use {
		'nvim-lualine/lualine.nvim',
		event = lazy_event_enter_file,
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = misc.lualine
	}

	use {
		"lukas-reineke/indent-blankline.nvim",
		event = lazy_event_enter_file,
	}

	use {
		"RRethy/vim-illuminate",
		event = lazy_event_enter_file,
	}

	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
		cmd = {"NvimTreeToggle","NvimTreeFindFileToggle"},
		config = function()
			require('plugins.nvim-tree')
		end,
	}

	use {
		'ethanholz/nvim-lastplace',
		event = lazy_event_enter_file,
		config = function()
			require('nvim-lastplace').setup()
		end
	}

	use {
		'goolord/alpha-nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function ()
			require('plugins.alpha')
		end
	}

	use {
		'numToStr/Comment.nvim',
		event = lazy_event_enter_file,
		config = function()
			require('Comment').setup()
		end
	}

	use {
		'nvim-telescope/telescope.nvim',
		cmd = "Telescope",
		requires = {'nvim-lua/plenary.nvim'},
		config = function ()
			require('plugins.telescope')
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

	use 'lewis6991/impatient.nvim'


	use {
		'nvim-treesitter/nvim-treesitter',
		event = lazy_event_enter_file,
		run = ':TSUpdate',
		config = function()
			require('plugins.treesitter')
		end

	}

	use {
		"windwp/nvim-autopairs",
		event = lazy_event_enter_file,
		config = function()
			require("nvim-autopairs").setup {}
		end
	}

	use {
		'phaazon/hop.nvim',
		event = lazy_event_enter_file,
		config = function()
			require'hop'.setup{}
		end
	}

	use {
		'williamboman/nvim-lsp-installer',
		config = function()
			require('plugins.lspinstaller')
		end
	}

	use {
		'neovim/nvim-lspconfig',
		after = "nvim-lsp-installer",
		config = function()
			require('plugins.lspconfig')
		end
	}


	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		event = lazy_event_enter_file,
		config = function()
			require("trouble").setup {}
		end
	}

	use {
		'hrsh7th/nvim-cmp',-- Autocompletion plugin
		config = function()
			require"plugins.nvim-cmp"
		end
	}

	use {
		'tzachar/cmp-tabnine',
		run='./install.sh',
		requires = 'hrsh7th/nvim-cmp',
		after = "nvim-cmp"
	}

	use {
		"ray-x/lsp_signature.nvim",
		after = 'nvim-cmp',
		config = misc.lsp_signature
	}

	local cmp_plugin_list = {
		'hrsh7th/cmp-nvim-lsp',
		'saadparwaiz1/cmp_luasnip',
		'L3MON4D3/LuaSnip',
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

	use {
		'mfussenegger/nvim-dap',
		event = lazy_event_enter_file,
		config = function ()
			require('plugins.dap')
		end
	}

	use {
		"rcarriga/nvim-dap-ui",
		requires = {'mfussenegger/nvim-dap'},
		after = 'nvim-dap',
		config = function ()
			require('plugins.dap-ui')
		end
	}

	use {
		'theHamsta/nvim-dap-virtual-text',
		after = 'nvim-dap',
		requires = {"mfussenegger/nvim-dap"},
		config = function ()
			require('nvim-dap-virtual-text').setup()
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
		'tpope/vim-surround',
		event = lazy_event_enter_file,
	}

	use {
		'tpope/vim-repeat',
		event = lazy_event_enter_file,
	}

	use {
		'akinsho/bufferline.nvim',
		event = lazy_event_enter_file,
		tag = "v2.*",
		requires = 'kyazdani42/nvim-web-devicons',
		config = function ()
			require('bufferline').setup{}
		end
	}

	use {
		'rcarriga/nvim-notify',
		config = function ()
			require('plugins.notify')
		end
	}

	use {
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup{}
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
		'rmagatti/auto-session',
		config = misc.auto_session
	}

	use {
		'rmagatti/session-lens',
		requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
		config = function()
			require('session-lens').setup{}
		end
	}



	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end

require('packer').startup({load_plugins_function,config = misc.packer_config})
