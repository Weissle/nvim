local M = {}
local config = {
	-- don't change the group unless you want to disable a group of plugins at once.
	group = {
		lsp = true,
		cmp = true,
		ui = true,
		ez = true,
		doc = true,
		session = true,
		debug = true,
	},
	lazy_event_enter_file = { "BufReadPre", "BufNewFile" },
}

require("core").merge_configs(config, "plugins.plugins.config")
local lazy_event_enter_file = config.lazy_event_enter_file

M["wbthomason/packer.nvim"] = {
	cmd = { "PackerInstall", "PackerSync", "PackerStatus", "PackerCompile", "PackerProfile", "PackerClean" },
	config = function()
		require("plugins.setup_manager").setup("wbthomason/packer.nvim")
	end,
}

M["lewis6991/impatient.nvim"] = {}

M["nvim-lua/plenary.nvim"] = {
	module = "plenary",
}

M["kyazdani42/nvim-tree.lua"] = {
	cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFocus" },
	config = function()
		require("plugins.setup_manager").setup("kyazdani42/nvim-tree.lua")
	end,
}

M["williamboman/mason.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("plugins.setup_manager").setup("williamboman/mason.nvim")
	end,
}
M["nvim-telescope/telescope.nvim"] = {
	branch = "0.1.x",
	requires = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
			after = "telescope.nvim",
			config = function()
				require("plugins.setup_manager").setup("nvim-telescope/telescope-fzf-native.nvim")
			end,
		},
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			after = "telescope.nvim",
			config = function()
				require("plugins.setup_manager").setup("nvim-telescope/telescope-live-grep-args.nvim")
			end,
		},
	},
	config = function()
		require("plugins.setup_manager").setup("nvim-telescope/telescope.nvim")
	end,
}

M["nvim-treesitter/nvim-treesitter"] = {
	run = ":TSUpdate",
	event = lazy_event_enter_file,
	config = function()
		require("plugins.setup_manager").setup("nvim-treesitter/nvim-treesitter")
	end,
}

M["L3MON4D3/LuaSnip"] = {
	module = "luasnip",
	event = { "BufRead", "BufNewFile", "InsertEnter" },
	config = function()
		require("plugins.setup_manager").setup("L3MON4D3/LuaSnip")
	end,
}

if config.group.lsp ~= false then
	M["williamboman/mason-lspconfig.nvim"] = {
		after = { "mason.nvim" },
		config = function()
			require("plugins.setup_manager").setup("williamboman/mason-lspconfig.nvim")
		end,
	}

	M["neovim/nvim-lspconfig"] = {
		after = { "mason-lspconfig.nvim" },
		config = function()
			require("plugins.setup_manager").setup("neovim/nvim-lspconfig")
		end,
	}

	M["simrat39/symbols-outline.nvim"] = {
		cmd = { "SymbolsOutline" },
		config = function()
			require("plugins.setup_manager").setup("simrat39/symbols-outline.nvim")
		end,
	}
	M["jose-elias-alvarez/null-ls.nvim"] = {
		after = { "mason-lspconfig.nvim" },
		config = function()
			require("plugins.setup_manager").setup("jose-elias-alvarez/null-ls.nvim")
		end,
	}

	M["jayp0521/mason-null-ls.nvim"] = {
		after = { "null-ls.nvim" },
		config = function()
			require("plugins.setup_manager").setup("jayp0521/mason-null-ls.nvim")
		end,
	}
end

if config.group.cmp ~= false then
	M["rafamadriz/friendly-snippets"] = {}

	M["hrsh7th/nvim-cmp"] = {
		after = "LuaSnip",
		keys = { ":", "/" },
		config = function()
			require("plugins.setup_manager").setup("hrsh7th/nvim-cmp")
		end,
	}

	M["hrsh7th/cmp-nvim-lsp"] = {
		module = "cmp_nvim_lsp",
		after = "nvim-cmp",
	}

	M["saadparwaiz1/cmp_luasnip"] = {
		after = "nvim-cmp",
	}

	M["hrsh7th/cmp-buffer"] = {
		after = "nvim-cmp",
	}

	M["hrsh7th/cmp-path"] = {
		after = "nvim-cmp",
	}

	M["hrsh7th/cmp-cmdline"] = {
		after = "nvim-cmp",
	}
end

if config.group.ui then
	M["kyazdani42/nvim-web-devicons"] = {
		module = "nvim-web-devicons",
	}

	M["folke/tokyonight.nvim"] = {
		config = function()
			require("plugins.setup_manager").setup("folke/tokyonight.nvim")
		end,
	}

	M["rcarriga/nvim-notify"] = {
		config = function()
			require("plugins.setup_manager").setup("rcarriga/nvim-notify")
		end,
	}

	M["stevearc/dressing.nvim"] = {
		config = function()
			require("plugins.setup_manager").setup("stevearc/dressing.nvim")
		end,
	}

	M["lukas-reineke/indent-blankline.nvim"] = {
		event = lazy_event_enter_file,
	}

	M["nvim-lualine/lualine.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup_manager").setup("nvim-lualine/lualine.nvim")
		end,
	}

	M["akinsho/bufferline.nvim"] = {
		tag = "v2.*",
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup_manager").setup("akinsho/bufferline.nvim")
		end,
	}

	-- INFO: This plugin override the keymap. So it is disabled by default in case users' keymaps are overrided while they don't know.
	M["karb94/neoscroll.nvim"] = {
		disable = true,
	}

end

if config.group.ez ~= false then
	M["phaazon/hop.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup_manager").setup("phaazon/hop.nvim")
		end,
	}

	M["echasnovski/mini.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup_manager").setup("echasnovski/mini.nvim")
		end,
	}

	M["kevinhwang91/nvim-ufo"] = {
		after = { "nvim-treesitter" },
		requires = {
			{
				"kevinhwang91/promise-async",
				module = "promise",
			},
		},
		config = function()
			require("plugins.setup_manager").setup("kevinhwang91/nvim-ufo")
		end,
	}

	M["mrjones2014/smart-splits.nvim"] = {
		cmd = "SmartResizeMode",
		config = function()
			require("plugins.setup_manager").setup("mrjones2014/smart-splits.nvim")
		end,
	}

	M["windwp/nvim-spectre"] = {
		module = "spectre",
		config = function()
			require("plugins.setup_manager").setup("windwp/nvim-spectre")
		end,
	}

	M["ethanholz/nvim-lastplace"] = {
		event = { "BufReadPre" },
		config = function()
			require("plugins.setup_manager").setup("ethanholz/nvim-lastplace")
		end,
	}

	M["gbprod/yanky.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup_manager").setup("gbprod/yanky.nvim")
		end,
	}

	M["nvim-treesitter/nvim-treesitter-textobjects"] = {
		after = "nvim-treesitter",
		config = function()
			require("plugins.setup_manager").setup("nvim-treesitter/nvim-treesitter-textobjects")
		end,
	}
end

if config.group.doc ~= false then
	M["folke/todo-comments.nvim"] = {
		event = lazy_event_enter_file,
		cmd = { "TodoTelescope" },
		config = function()
			require("plugins.setup_manager").setup("folke/todo-comments.nvim")
		end,
	}

	M["danymat/neogen"] = {
		cmd = { "Neogen" },
		config = function()
			require("plugins.setup_manager").setup("danymat/neogen")
		end,
	}

	M["numToStr/Comment.nvim"] = {
		keys = { "gc", "gb" },
		config = function()
			require("plugins.setup_manager").setup("numToStr/Comment.nvim")
		end,
	}
end

if config.group.session ~= false then
	M["rmagatti/auto-session"] = {
		cond = function()
			return vim.g.auto_session_enabled ~= false
		end,
		requires = {
			"rmagatti/session-lens",
			after = { "telescope.nvim", "auto-session" },
			config = function()
				require("plugins.setup_manager").setup("rmagatti/session-lens")
			end,
		},
		config = function()
			require("plugins.setup_manager").setup("rmagatti/auto-session")
		end,
	}
end

if config.group.debug ~= false then
	M["mfussenegger/nvim-dap"] = {
		after = { "mason.nvim" },
		requires = {
			{
				"Weissle/persistent-breakpoints.nvim",
				after = "nvim-dap",
				config = function()
					require("plugins.setup_manager").setup("Weissle/persistent-breakpoints.nvim")
				end,
			},
		},
		config = function()
			require("plugins.setup_manager").setup("mfussenegger/nvim-dap")
		end,
	}

	M["rcarriga/nvim-dap-ui"] = {
		after = "nvim-dap",
		config = function()
			require("plugins.setup_manager").setup("rcarriga/nvim-dap-ui")
		end,
	}

	M["nvim-telescope/telescope-dap.nvim"] = {
		after = { "nvim-dap" },
		config = function()
			require("plugins.setup_manager").setup("nvim-telescope/telescope-dap.nvim")
		end,
	}

	M["theHamsta/nvim-dap-virtual-text"] = {
		after = "nvim-dap",
		config = function()
			require("plugins.setup_manager").setup("theHamsta/nvim-dap-virtual-text")
		end,
	}
end

M = require("core").merge_configs(M, "plugins.plugins")

return M
