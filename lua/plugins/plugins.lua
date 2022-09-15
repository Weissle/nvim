local M = {}

local group = {
	lsp = true,
	cmp = true,
	ui = true,
	ez = true,
	doc = true,
}

local lazy_event_enter_file = { "BufRead", "BufNewFile" }
local lazy_event_start_insert = { "InsertEnter" }

M["wbthomason/packer.nvim"] = {
	cmd = { "PackerInstall", "PackerSync", "PackerStatus", "PackerCompile", "PackerProfile", "PackerClean" },
	config = function()
		require("plugins.setup.packer").setup({})
	end,
}

M["nvim-lua/plenary.nvim"] = {
	module = "plenary",
}

M["williamboman/mason.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("mason").setup({})
	end,
}

M["kyazdani42/nvim-tree.lua"] = {
	cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
	config = function()
		require("plugins.setup.nvim-tree").setup({})
	end,
}

M["nvim-telescope/telescope.nvim"] = {
	cmd = { "Telescope" },
	keys = { "<leader>fk" },
	branch = "0.1.x",
	requires = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
			after = "telescope.nvim",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	config = function()
		require("plugins.setup.telescope").setup({})
		require("mappings.fl_mappings").telescope()
	end,
}

M["nvim-treesitter/nvim-treesitter"] = {
	run = ":TSUpdate",
	event = lazy_event_enter_file,
	config = function()
		require("plugins.setup.treesitter").setup({})
	end,
}

if group.lsp ~= false then
	M["williamboman/mason-lspconfig.nvim"] = {
		after = { "mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = require("common").get_lsp_server_list(),
			})
		end,
	}

	M["neovim/nvim-lspconfig"] = {
		after = { "mason-lspconfig.nvim" },
		requires = {
			{
				"folke/lua-dev.nvim",
				module = "lua-dev",
			},
		},
		config = function()
			require("lua-dev").setup({})
			require("plugins.setup.lspconfig").setup({})
			require("mappings.fl_mappings").lspconfig()
		end,
	}

	M["ray-x/lsp_signature.nvim"] = {
		after = { "nvim-lspconfig" },
		config = function()
			require("lsp_signature").setup({
				bind = true,
				handler_opts = {
					border = "rounded",
				},
			})
		end,
	}

	M["simrat39/symbols-outline.nvim"] = {
		cmd = { "SymbolsOutline" },
		config = function()
			require("symbols-outline").setup()
		end,
	}

	M["folke/trouble.nvim"] = {
		cmd = { "Trouble", "TroubleToggle" },
		config = function()
			require("trouble").setup({})
		end,
	}

	M["smjonas/inc-rename.nvim"] = {
		keys = { "<leader>lr" },
		config = function()
			require("inc_rename").setup({
				input_buffer_type = "dressing",
			})
			require("mappings.fl_mappings").inc_rename()
		end,
	}
end

if group.cmp ~= false then
	M["rafamadriz/friendly-snippets"] = {}

	M["L3MON4D3/LuaSnip"] = {
		module = "luasnip",
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup.luasnip").setup({})
		end,
	}

	M["hrsh7th/nvim-cmp"] = {
		after = "LuaSnip",
		keys = { ":", "/" },
		config = function()
			require("plugins.setup.nvim-cmp").setup({})
		end,
	}

	M["hrsh7th/cmp-nvim-lsp"] = {
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

	M["ray-x/cmp-treesitter"] = {
		event = lazy_event_start_insert,
	}

	M["kdheepak/cmp-latex-symbols"] = {
		event = lazy_event_start_insert,
	}
end

if group.ui then
	M["kyazdani42/nvim-web-devicons"] = {
		module = "nvim-web-devicons",
	}

	M["folke/tokyonight.nvim"] = {
		config = function()
			require("plugins.setup.tokyonight").setup({})
		end,
	}

	M["rcarriga/nvim-notify"] = {
		config = function()
			vim.notify = require("notify")
		end,
	}

	M["stevearc/dressing.nvim"] = {
		config = function()
			require("dressing").setup({})
		end,
	}

	M["lukas-reineke/indent-blankline.nvim"] = {
		event = lazy_event_enter_file,
	}

	M["nvim-lualine/lualine.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup.lualine").setup({})
		end,
	}

	M["akinsho/bufferline.nvim"] = {
		tag = "v2.*",
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup.bufferline").setup({})
			require("mappings.fl_mappings").bufferline()
		end,
	}

	M["karb94/neoscroll.nvim"] = {
		keys = { "<C-u>", "<C-d>", "<C-y>", "<C-e>" },
		config = function()
			require("neoscroll").setup({ mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>" } })
		end,
	}
end

if group.ez ~= false then
	M["phaazon/hop.nvim"] = {
		branch = "v2",
		cmd = { "HopLineStartMW", "HopWordMW", "HopChar2MW", "HopPatternMW" },
		keys = { "<leader>hf", "<leader>hF", "<leader>ht", "<leader>hT", "<leader>he" },
		config = function()
			require("hop").setup({})
			require("mappings.fl_mappings").hop()
		end,
	}

	M["echasnovski/mini.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup.mini").setup({})
			require("mappings.fl_mappings").bufremove()
		end,
	}
	M["rmagatti/auto-session"] = {
		cond = function()
			return vim.g.auto_session_enabled ~= false
		end,
		config = function()
			require("plugins.setup.auto-session").setup()
		end,
	}

	M["rmagatti/session-lens"] = {
		after = { "telescope.nvim", "auto-session" },
		config = function()
			require("session-lens").setup({})
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
			require("plugins.setup.nvim-ufo").setup({})
			require("mappings.fl_mappings").ufo()
		end,
	}

	M["mrjones2014/smart-splits.nvim"] = {
		cmd = "SmartResizeMode",
		config = function()
			require("plugins.setup.smart-splits").setup()
		end,
	}

	M["numToStr/Comment.nvim"] = {
		keys = { "gcc", "gc", "gb" },
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
end

if group.doc ~= false then
	M["folke/todo-comments.nvim"] = {
		event = lazy_event_enter_file,
		cmd = { "TodoTelescope" },
		config = function()
			require("todo-comments").setup({})
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

	M["danymat/neogen"] = {
		cmd = { "Neogen" },
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
			})
		end,
	}
end

return M
