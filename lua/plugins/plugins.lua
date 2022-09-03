local M = {}

local lazy_event_enter_file = { "BufReadPre", "BufNewFile" }
local lazy_event_start_insert = { "InsertEnter" }
local module_activate = {
	debug = false,
}

M["wbthomason/packer.nvim"] = {
	cmd = { "PackerInstall", "PackerSync", "PackerStatus", "PackerCompile", "PackerProfile" },
}

M["kyazdani42/nvim-web-devicons"] = {}

M["nvim-lua/plenary.nvim"] = {}

M["lewis6991/impatient.nvim"] = {}

M["rafamadriz/friendly-snippets"] = {
	event = lazy_event_start_insert,
}

M["lukas-reineke/indent-blankline.nvim"] = {
	event = lazy_event_enter_file,
}

M["tpope/vim-repeat"] = {
	event = lazy_event_enter_file,
}

M["folke/tokyonight.nvim"] = {
	config = function()
		require("plugins.setup.tokyonight").setup({})
	end,
}

M["nvim-lualine/lualine.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("plugins.setup.lualine").setup({})
	end,
}

M["rmagatti/auto-session"] = {
	config = function()
		require("plugins.setup.auto-session").setup()
	end,
}

M["ray-x/lsp_signature.nvim"] = {
	event = lazy_event_start_insert,
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
	event = lazy_event_enter_file,
	config = function()
		require("plugins.setup.smart-splits").setup()
		require("mappings.fl_mappings").smart_split()
	end,
}

M["danymat/neogen"] = {
	event = lazy_event_start_insert,
	after = "LuaSnip",
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
		})
		require("mappings.fl_mappings").neogen()
	end,
}

M["williamboman/mason-lspconfig.nvim"] = {
	after = "mason.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = require("common").get_lsp_server_list(),
		})
	end,
}

M["windwp/nvim-autopairs"] = {
	disable = true,
	event = lazy_event_start_insert,
	config = function()
		require("nvim-autopairs").setup({})
	end,
}

M["folke/trouble.nvim"] = {
	cmd = { "Trouble", "TroubleToggle" },
	config = function()
		require("trouble").setup({})
	end,
}

M["folke/todo-comments.nvim"] = {
	event = lazy_event_enter_file,
	cmd = { "TodoTelescope" },
	config = function()
		require("todo-comments").setup({})
		require("mappings.fl_mappings").todo_comments()
	end,
}

M["theHamsta/nvim-dap-virtual-text"] = {
	disable = not module_activate.debug,
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
	disable = not module_activate.debug,
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
	disable = true,
	config = function()
		require("spectre").setup({})
	end,
}

M["williamboman/mason.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("mason").setup({})
	end,
}

M["rcarriga/nvim-notify"] = {
	event = lazy_event_enter_file,
	config = function()
		vim.defer_fn(function()
			require("plugins.setup.notify").setup({})
			require("mappings.fl_mappings").notify()
		end, 5000)
	end,
}

M["kyazdani42/nvim-tree.lua"] = {
	cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
	config = function()
		require("plugins.setup.nvim-tree").setup({})
	end,
}

M["rcarriga/nvim-dap-ui"] = {
	disable = not module_activate.debug,
	after = "nvim-dap",
	config = function()
		require("plugins.setup.dap-ui").setup({})
		require("mappings.fl_mappings").dapui()
	end,
}

M["mfussenegger/nvim-dap"] = {
	disable = not module_activate.debug,
	after = { "mason.nvim" },
	config = function()
		require("plugins.setup.dap").setup({})
		require("mappings.fl_mappings").dap()
	end,
}

M["neovim/nvim-lspconfig"] = {
	after = { "cmp-nvim-lsp", "mason-lspconfig.nvim" },
	config = function()
		require("plugins.setup.lspconfig").setup({})
		require("mappings.fl_mappings").lspconfig()
	end,
}

M["nvim-telescope/telescope.nvim"] = {
	branch = "0.1.x",
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
	after = "friendly-snippets",
	config = function()
		require("luasnip").setup({
			region_check_events = "InsertEnter",
		})
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}

M["hrsh7th/cmp-nvim-lsp"] = {}

M["saadparwaiz1/cmp_luasnip"] = {
	event = lazy_event_start_insert,
}

M["hrsh7th/cmp-buffer"] = {
	event = lazy_event_start_insert,
}

M["hrsh7th/cmp-path"] = {
	event = lazy_event_start_insert,
}

M["hrsh7th/cmp-cmdline"] = {
	event = lazy_event_start_insert,
}

M["hrsh7th/cmp-nvim-lua"] = {
	event = lazy_event_start_insert,
}

M["ray-x/cmp-treesitter"] = {
	event = lazy_event_start_insert,
}

M["hrsh7th/nvim-cmp"] = {
	event = lazy_event_start_insert,
	after = { "LuaSnip" },
	config = function()
		require("plugins.setup.nvim-cmp").setup({})
	end,
}

M["nvim-telescope/telescope-dap.nvim"] = {
	disable = not module_activate.debug,
	after = { "telescope.nvim", "nvim-dap" },
	config = function()
		require("telescope").load_extension("dap")
	end,
}

M["akinsho/bufferline.nvim"] = {
	tag = "v2.*",
	event = lazy_event_enter_file,
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
		require("plugins.setup.bufferline").setup({})
	end,
}

M["phaazon/hop.nvim"] = {
	branch = "v2", -- optional but strongly recommended
	event = lazy_event_enter_file,
	config = function()
		require("hop").setup({})
		require("mappings.fl_mappings").hop()
	end,
}

M["karb94/neoscroll.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("neoscroll").setup({ mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>" } })
	end,
}

M["echasnovski/mini.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("plugins.setup.mini").setup({})
	end,
}

M["iamcco/markdown-preview.nvim"] = {
	ft = { "markdown" },
	run = "cd app && npm install",
	setup = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	config = function()
		require("plugins.setup.markdown-preview").setup({})
	end,
}

M["kevinhwang91/nvim-ufo"] = {
	event = lazy_event_enter_file,
	requires = "kevinhwang91/promise-async",
	config = function()
		require("plugins.setup.nvim-ufo").setup({})
		require("mappings.fl_mappings").ufo()
	end,
}

return M
