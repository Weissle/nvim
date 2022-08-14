local M = {}

-- local lazy_event_enter_file = { "UIEnter" }
local lazy_event_enter_file = { "BufReadPre" }
-- local lazy_event_enter_file = nil

--	load_plugins,

M["kyazdani42/nvim-web-devicons"] = {}

M["nvim-lua/plenary.nvim"] = {}

M["lewis6991/impatient.nvim"] = {}

M["rafamadriz/friendly-snippets"] = {}

M["wbthomason/packer.nvim"] = {}

M["famiu/bufdelete.nvim"] = {
	event = lazy_event_enter_file,
}

M["lukas-reineke/indent-blankline.nvim"] = {
	event = lazy_event_enter_file,
}

M["RRethy/vim-illuminate"] = {
	event = lazy_event_enter_file,
}

M["tpope/vim-surround"] = {
	event = lazy_event_enter_file,
}

M["tpope/vim-repeat"] = {
	event = lazy_event_enter_file,
}

M["folke/tokyonight.nvim"] = {
	config = function()
		vim.cmd("colorscheme tokyonight")
		vim.cmd("hi Visual guibg=#006699")
	end,
}

M["nvim-lualine/lualine.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("lualine").setup({
			options = {
				theme = "tokyonight",
				disabled_filetypes = {
					"dapui_console",
					"dap-repl",
					"dapui_breakpoints",
					"dapui_stacks",
					"dapui_scopes",
					"dapui_watches",
				},
			},
		})
	end,
}

M["rmagatti/auto-session"] = {
	config = function()
		require("plugins.setup.auto-session").setup()
	end,
}

M["ray-x/lsp_signature.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("lsp_signature").setup({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			handler_opts = {
				border = "rounded",
			},
		})
	end,
}

M["mrjones2014/smart-splits.nvim"] = {
	config = function()
		require("plugins.setup.smart-splits").setup()
		require("mappings.fl_mappings").smart_split()
	end,
}

M["danymat/neogen"] = {
	event = lazy_event_enter_file,
	after = "LuaSnip",
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
		})
		require("mappings.fl_mappings").neogen()
	end,
}

M["williamboman/mason-lspconfig.nvim"] = {
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = require("common").get_lsp_server_list(),
		})
	end,
}

M["windwp/nvim-autopairs"] = {
	event = lazy_event_enter_file,
	config = function()
		require("nvim-autopairs").setup({})
	end,
}

M["folke/trouble.nvim"] = {
	config = function()
		require("trouble").setup({})
	end,
}

M["folke/todo-comments.nvim"] = {
	config = function()
		require("todo-comments").setup({})
		require("mappings.fl_mappings").todo_comments()
	end,
}

M["theHamsta/nvim-dap-virtual-text"] = {
	event = lazy_event_enter_file,
	after = "nvim-dap",
	config = function()
		require("nvim-dap-virtual-text").setup({})
	end,
}

M["rmagatti/session-lens"] = {
	after = "telescope.nvim",
	config = function()
		require("session-lens").setup({})
		require("mappings.fl_mappings").session_lens()
	end,
}

M["Weissle/persistent-breakpoints.nvim"] = {
	event = lazy_event_enter_file,
	after = "nvim-dap",
	config = function()
		require("persistent-breakpoints").setup({})
		vim.api.nvim_create_autocmd(
			{ "BufReadPost" },
			{ callback = require("persistent-breakpoints.api").load_breakpoints }
		)
	end,
}

M["numToStr/Comment.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("Comment").setup({})
	end,
}

M["windwp/nvim-spectre"] = {
	config = function()
		require("spectre").setup({})
	end,
}

M["williamboman/mason.nvim"] = {
	config = function()
		require("mason").setup({})
	end,
}

M["rcarriga/nvim-notify"] = {
	after = "nvim-dap",
	config = function()
		require("plugins.setup.notify").setup({})
		require("mappings.fl_mappings").notify()
	end
}

M["kyazdani42/nvim-tree.lua"] = {
	config = function ()
		require("plugins.setup.nvim-tree").setup({})
		require("mappings.fl_mappings").nvim_tree()
	end
}

M["rcarriga/nvim-dap-ui"] = {
	after = "nvim-dap",
	config = function()
		require("plugins.setup.dap-ui").setup({})
		require("mappings.fl_mappings").dapui()
	end
}

M["mfussenegger/nvim-dap"] = {
	after = "mason.nvim",
	config = function()
		require("plugins.setup.dap").setup({})
		require("mappings.fl_mappings").dap()
	end
}

M["neovim/nvim-lspconfig"] = {
	after = "cmp-nvim-lsp",
	config = function()
		require("plugins.setup.lspconfig").setup({})
		require("mappings.fl_mappings").lspconfig()
	end
}

M["nvim-telescope/telescope.nvim"] = {
	branch = "0.1.x",
	requires = {},
	config = function()
		require("plugins.setup.telescope").setup({})
		require("mappings.fl_mappings").telescope()
	end,
}

M["nvim-telescope/telescope-fzf-native.nvim"] = {
	run = "make",
	after = "telescope.nvim",
	config = function()
		require("telescope").load_extension("fzf")
	end,
}

M["nvim-treesitter/nvim-treesitter"] = {
	run = ":TSUpdate",
	event = lazy_event_enter_file,
	config = function()
		require("plugins.setup.treesitter").setup({})
	end,
}

M["L3MON4D3/LuaSnip"] = {
	event = lazy_event_enter_file,
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}

M["hrsh7th/cmp-nvim-lsp"] = {
	event = lazy_event_enter_file,
}

M["saadparwaiz1/cmp_luasnip"] = {
	event = lazy_event_enter_file,
}

M["hrsh7th/cmp-buffer"] = {
	event = lazy_event_enter_file,
	config = function ()
		require("mappings.fl_mappings").bufferline()
	end
}

M["hrsh7th/cmp-path"] = {
	event = lazy_event_enter_file,
}

M["hrsh7th/cmp-cmdline"] = {
	event = lazy_event_enter_file,
}

M["hrsh7th/cmp-nvim-lua"] = {
	event = lazy_event_enter_file,
}

M["ray-x/cmp-treesitter"] = {
	event = lazy_event_enter_file,
}

M["hrsh7th/nvim-cmp"] = {
	event = lazy_event_enter_file,
	after = {"LuaSnip", "cmp-nvim-lsp", "cmp_luasnip","cmp-buffer","cmp-path","cmp-cmdline","cmp-nvim-lua","cmp-treesitter"},
	config = function()
		require("plugins.setup.nvim-cmp").setup({})
	end,
}

M["nvim-telescope/telescope-dap.nvim"] = {
	after = "telescope.nvim",
	config = function()
		require("telescope").load_extension("dap")
	end,
}

M["akinsho/bufferline.nvim"] = {
	tag = "v2.*",
	event = lazy_event_enter_file,
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
		require("bufferline").setup({})
	end,
}

M["akinsho/toggleterm.nvim"] = {
	tag = "v2.*",
	config = function()
		require("plugins.setup.toggleterm").setup({})
		require("mappings.fl_mappings").toggleterm()
	end,
}

M["phaazon/hop.nvim"] = {
	"phaazon/hop.nvim",
	branch = "v2", -- optional but strongly recommended
	event = lazy_event_enter_file,
	config = function()
		require("hop").setup({})
		require("mappings.fl_mappings").hop()
	end,
}

return M
