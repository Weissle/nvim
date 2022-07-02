fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').init({
	profile = {
		enable = true,
		threshold = 1,
	},
})

local lazy_event_enter_file = {'BufRead','BufNewFile'}

local load_plugins_function = function(use)
	use 'wbthomason/packer.nvim'

	use {
		'folke/tokyonight.nvim',
		config = function ()
			vim.cmd('colorscheme tokyonight')
			vim.cmd('hi Visual guibg=#006699')
		end
	}

	use {
		'nvim-lualine/lualine.nvim',
		event = lazy_event_enter_file,
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup {
				options = {
					theme = 'tokyonight'
				},
			}
		end,
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
			require('telescope').setup {
				extensions = {
					fzf = {
						fuzzy = true,                    -- false will only do exact matching
						override_generic_sorter = true,  -- override the generic sorter
						override_file_sorter = true,     -- override the file sorter
						case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					}
				},
				defaults = {
					mappings = require('mappings.pl_mappings').telescope()
				}
			}
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
		-- branch = 'v1.3', -- optional but strongly recommended
		event = lazy_event_enter_file,
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
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
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

	use {
		"ray-x/lsp_signature.nvim",
		event = lazy_event_enter_file,
		config = function()
			require "lsp_signature".setup {
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				handler_opts = {
					border = "rounded"
				}
			}
		end
	}

	use {
		'hrsh7th/nvim-cmp',-- Autocompletion plugin
		after = "nvim-lspconfig",
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
	}

	use {
		"rcarriga/nvim-dap-ui",
		requires = {'mfussenegger/nvim-dap'},
		after = 'nvim-dap',
		config = function ()
			require('dapui').setup()
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
		'skywind3000/asynctasks.vim',
		requires = { 'skywind3000/asyncrun.vim'},
		config = function ()
			vim.g.asyncrun_open = 6
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
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end

local packer_config = {
	display = {
		working_sym = " ﲊ",
		error_sym = "✗ ",
		done_sym = " ",
		removed_sym = " ",
		moved_sym = "",
		open_fn = function()
			return require('packer.util').float({border='single'})
		end
	}
}

return require('packer').startup({load_plugins_function,config = packer_config})
