local M = {}
local config = {
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
		require("plugins.setup.packer").setup()
	end,
}

M["lewis6991/impatient.nvim"] = {}

M["nvim-lua/plenary.nvim"] = {
	module = "plenary",
}

M["kyazdani42/nvim-tree.lua"] = {
	cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFocus" },
	setup = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		require("mappings.plugin_preset").nvim_tree()
	end,
	config = function()
		require("plugins.setup.nvim-tree").setup()
	end,
}

M["williamboman/mason.nvim"] = {
	event = lazy_event_enter_file,
	config = function()
		require("mason").setup()
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
				require("telescope").load_extension("fzf")
			end,
		},
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			setup = function()
				require("plugins.override")["mappings.plugin_after.telescope"] = function(C)
					C["n"]["<leader>fg"] =
						"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>"
				end
			end,
			after = "telescope.nvim",
			config = function()
				require("telescope").load_extension("live_grep_args")
			end,
		},
	},
	config = function()
		require("plugins.setup.telescope").setup()
		require("mappings.plugin_after").telescope()
	end,
}

M["nvim-treesitter/nvim-treesitter"] = {
	run = ":TSUpdate",
	event = lazy_event_enter_file,
	config = function()
		require("plugins.setup.treesitter").setup()
	end,
}

M["L3MON4D3/LuaSnip"] = {
	module = "luasnip",
	event = { "BufRead", "BufNewFile", "InsertEnter" },
	config = function()
		require("plugins.setup.luasnip").setup()
	end,
}

if config.group.lsp ~= false then
	M["williamboman/mason-lspconfig.nvim"] = {
		after = { "mason.nvim" },
		config = function()
			require("plugins.setup.mason-lspconfig").setup()
		end,
	}

	M["neovim/nvim-lspconfig"] = {
		after = { "mason-lspconfig.nvim" },
		config = function()
			require("plugins.setup.lspconfig").setup()
			require("mappings.plugin_after").lspconfig()
		end,
	}

	M["simrat39/symbols-outline.nvim"] = {
		cmd = { "SymbolsOutline" },
		setup = function()
			require("mappings.plugin_preset").symbols_outline()
		end,
		config = function()
			require("symbols-outline").setup()
		end,
	}

	M["smjonas/inc-rename.nvim"] = {
		disable = require("core").vim_version < "0.8.0",
		setup = function()
			require("plugins.override")["mappings.plugin_after.lspconfig"] = function(C)
				C["n"]["<leader>lr"] = {
					function()
						return ":IncRename " .. vim.fn.expand("<cword>")
					end,
					opts = {
						expr = true,
						silent = true,
					},
				}
			end
		end,
		after = { "nvim-lspconfig" },
		config = function()
			require("plugins.setup.inc-rename").setup()
		end,
	}

	M["jose-elias-alvarez/null-ls.nvim"] = {
		after = { "mason-lspconfig.nvim" },
		config = function()
			require("plugins.setup.null-ls").setup()
		end,
	}

	M["jayp0521/mason-null-ls.nvim"] = {
		after = { "null-ls.nvim" },
		config = function()
			require("plugins.setup.mason-null-ls").setup()
		end,
	}
end

if config.group.cmp ~= false then
	M["rafamadriz/friendly-snippets"] = {}

	M["hrsh7th/nvim-cmp"] = {
		after = "LuaSnip",
		keys = { ":", "/" },
		config = function()
			require("plugins.setup.nvim-cmp").setup()
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
			require("plugins.setup.tokyonight").setup()
		end,
	}

	M["rcarriga/nvim-notify"] = {
		config = function()
			vim.notify = require("notify")
			require("telescope").load_extension("notify")
			require("mappings.plugin_after").notify()
		end,
	}

	M["stevearc/dressing.nvim"] = {
		config = function()
			require("dressing").setup()
		end,
	}

	M["lukas-reineke/indent-blankline.nvim"] = {
		event = lazy_event_enter_file,
	}

	M["nvim-lualine/lualine.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup.lualine").setup()
		end,
	}

	M["akinsho/bufferline.nvim"] = {
		tag = "v2.*",
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup.bufferline").setup()
			require("mappings.plugin_after").bufferline()
		end,
	}

	M["karb94/neoscroll.nvim"] = {
		keys = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" },
		config = function()
			require("neoscroll").setup({ mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" } })
		end,
	}
end

if config.group.ez ~= false then
	M["phaazon/hop.nvim"] = {
		module = "hop",
		cmd = { "HopLineStartMW", "HopWordMW" },
		setup = function()
			require("mappings.plugin_preset").hop()
		end,
		config = function()
			require("hop").setup()
		end,
	}

	M["echasnovski/mini.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup.mini").setup()
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
			require("plugins.setup.nvim-ufo").setup()
			require("mappings.plugin_after").ufo()
		end,
	}

	M["mrjones2014/smart-splits.nvim"] = {
		cmd = "SmartResizeMode",
		setup = function()
			require("mappings.plugin_preset").smart_split()
		end,
		config = function()
			require("plugins.setup.smart-splits").setup()
		end,
	}

	M["windwp/nvim-spectre"] = {
		module = "spectre",
		setup = function()
			require("mappings.plugin_preset").spectre()
		end,
		config = function()
			require("spectre").setup()
		end,
	}

	M["ethanholz/nvim-lastplace"] = {
		event = { "BufReadPre" },
		config = function()
			require("plugins.setup.nvim-lastplace").setup()
		end,
	}

	M["gbprod/yanky.nvim"] = {
		event = lazy_event_enter_file,
		config = function()
			require("plugins.setup.yanky").setup()
			require("mappings.plugin_after").yanky()
		end,
	}
end

if config.group.doc ~= false then
	M["folke/todo-comments.nvim"] = {
		event = lazy_event_enter_file,
		setup = function()
			require("mappings.plugin_preset").todo_comments()
		end,
		cmd = { "TodoTelescope" },
		config = function()
			require("todo-comments").setup()
		end,
	}

	M["danymat/neogen"] = {
		cmd = { "Neogen" },
		setup = function()
			require("mappings.plugin_preset").neogen()
		end,
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
			})
		end,
	}

	M["numToStr/Comment.nvim"] = {
		keys = { "gc", "gb" },
		config = function()
			require("Comment").setup()
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
			setup = function()
				require("mappings.plugin_preset").session_lens()
			end,
			config = function()
				require("session-lens").setup()
			end,
		},
		config = function()
			require("plugins.setup.auto-session").setup()
		end,
	}
end

if config.group.debug ~= false then
	M["mfussenegger/nvim-dap"] = {
		after = { "mason.nvim" },
		config = function()
			require("plugins.setup.dap").setup()
			require("mappings.plugin_after").dap()
		end,
	}

	M["rcarriga/nvim-dap-ui"] = {
		after = "nvim-dap",
		config = function()
			require("plugins.setup.dapui").setup({})
			require("mappings.plugin_after").dapui()
		end,
	}

	M["Weissle/persistent-breakpoints.nvim"] = {
		module = "persistent-breakpoints.api",
		setup = function()
			require("plugins.override")["mappings.plugin_after.dap"] = function(C)
				C["n"]["<leader>ba"] = require("persistent-breakpoints.api").toggle_breakpoint
				C["n"]["<leader>bc"] = require("persistent-breakpoints.api").set_conditional_breakpoint
				C["n"]["<leader>bC"] = require("persistent-breakpoints.api").clear_all_breakpoints
			end
		end,
		config = function()
			require("persistent-breakpoints").setup({
				load_breakpoints_event = { "BufReadPost" },
			})
		end,
	}

	M["nvim-telescope/telescope-dap.nvim"] = {
		after = { "nvim-dap" },
		config = function()
			require("telescope").load_extension("dap")
			require("mappings.plugin_after").telescope_dap()
		end,
	}

	M["theHamsta/nvim-dap-virtual-text"] = {
		after = "nvim-dap",
		config = function()
			require("nvim-dap-virtual-text").setup({})
		end,
	}
end

M = require("core").merge_configs(M, "plugins.plugins")

return M
