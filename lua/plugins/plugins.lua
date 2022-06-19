fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').init({
	profile = {
		enable = true,
		threshold = 1,
	}
})

local lazy_event_enter_file = {'BufRead','BufNewFile'}

local load_plugins_function = function(use)
	use 'wbthomason/packer.nvim'

	use {
		'folke/tokyonight.nvim',
		config = function ()
			vim.cmd[[colorscheme tokyonight]]
			vim.cmd[[
			hi Visual guibg=#006699
			]]
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
				}
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
		cmd = "NvimTreeToggle",
		config = function()
			require('plugins.nvim-tree')
		end,
	}

	use {
		'ethanholz/nvim-lastplace',
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
		branch = 'v1.3', -- optional but strongly recommended
		event = lazy_event_enter_file,
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
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
		event = lazy_event_enter_file,
		config = function()
			require"plugins.nvim-cmp"
		end
	}
	use {
		'hrsh7th/cmp-nvim-lsp',
		after = "nvim-cmp"
	} -- LSP source for nvim-cmp
	use {
		'saadparwaiz1/cmp_luasnip',
		after = "nvim-cmp"
	} -- Snippets source for nvim-cmp
	use {
		'L3MON4D3/LuaSnip',
		after = "nvim-cmp"
	} -- Snippets plugin
	use {
		'hrsh7th/cmp-buffer',
		after = "nvim-cmp"
	}
	use {
		'hrsh7th/cmp-path',
		after = "nvim-cmp"
	}
	use {
		'hrsh7th/cmp-cmdline',
		after = "nvim-cmp"
	}



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
		event = lazy_event_enter_file,
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
