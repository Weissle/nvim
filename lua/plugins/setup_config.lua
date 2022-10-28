local _M = {}

_M["wbthomason/packer.nvim"] = {
	setup = {
		module = "plugins.setup.packer",
	},
}

_M["kyazdani42/nvim-tree.lua"] = {
	setup = {
		module = "nvim-tree",
		config = {
			git = {
				ignore = false,
			},
			view = {
				adaptive_size = true,
			},
		},
	},
}

_M["williamboman/mason.nvim"] = {
	setup = {
		module = "mason",
		config = {},
	},
}

_M["nvim-telescope/telescope.nvim"] = {
	setup = {
		module = "telescope",
		config = {
			defaults = {
				mappings = require("mappings.plugin_builtin").telescope(),
			},
		},
	},
}

_M["nvim-telescope/telescope-fzf-native.nvim"] = {
	after = {
		function()
			require("telescope").load_extension("fzf")
		end,
	},
}

_M["nvim-telescope/telescope-live-grep-args.nvim"] = {
	after = {
		function()
			require("telescope").load_extension("live_grep_args")
		end,
	},
}

_M["nvim-treesitter/nvim-treesitter"] = {
	setup = {
		module = "nvim-treesitter.configs",
		config = {
			ensure_installed = {},
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			textobjects = require("mappings.plugin_builtin").treesitter_textobjects(),
		},
	},
	after = {
		prefer_git = function()
			require("nvim-treesitter.install").prefer_git = true
		end,
	},
}

_M["L3MON4D3/LuaSnip"] = {
	setup = {
		module = "luasnip",
		config = {
			region_check_events = "InsertEnter",
		},
	},
	after = {
		load_snippets = function()
			require("luasnip.loaders.from_vscode").lazy_load({})
		end,
	},
}

_M["williamboman/mason-lspconfig.nvim"] = {
	setup = {
		module = "mason-lspconfig",
		config = { automatic_installation = true },
	},
}

_M["neovim/nvim-lspconfig"] = {
	preset = {},
	setup = {
		module = "plugins.setup.lspconfig",
	},
}
_M["simrat39/symbols-outline.nvim"] = {
	setup = {
		module = "symbols-outline",
	},
}

_M["jose-elias-alvarez/null-ls.nvim"] = {
	setup = {
		module = "plugins.setup.null-ls",
	},
}
_M["jayp0521/mason-null-ls.nvim"] = {
	setup = {
		module = "mason-null-ls",
		config = { automatic_installation = true },
	},
}

_M["hrsh7th/nvim-cmp"] = {
	setup = {
		module = "plugins.setup.nvim-cmp",
	},
}
_M["folke/tokyonight.nvim"] = {
	setup = {
		module = "tokyonight",
		config = {
			style = "moon",
			on_highlights = function(highlights, colors)
				highlights.WinSeparator = {
					fg = "#6699FF",
				}
			end,
		},
	},
	after = {
		set_colorscheme = "colorscheme tokyonight",
	},
}

_M["rcarriga/nvim-notify"] = {
	preset = {
		replace_vim_notify = function()
			vim.notify = require("notify")
		end,
	},
	setup = {
		module = "notify",
		config = {
			level = vim.log.levels.WARN,
		},
	},
	after = {
		use_telescope = function()
			require("telescope").load_extension("notify")
		end,
	},
}

_M["stevearc/dressing.nvim"] = {
	setup = {
		module = "dressing",
	},
}

_M["nvim-lualine/lualine.nvim"] = {
	setup = {
		module = "plugins.setup.lualine",
	},
}

_M["akinsho/bufferline.nvim"] = {
	setup = {
		module = "plugins.setup.bufferline",
	},
}

_M["phaazon/hop.nvim"] = {
	setup = {
		module = "hop",
	},
}

_M["echasnovski/mini.nvim"] = {
	setup = {
		module = "plugins.setup.mini",
	},
}

_M["kevinhwang91/nvim-ufo"] = {
	setup = {
		module = "plugins.setup.nvim-ufo",
	},
}
_M["mrjones2014/smart-splits.nvim"] = {
	setup = {
		module = "smart-splits",
		config = {},
	},
}

_M["windwp/nvim-spectre"] = {
	setup = {
		module = "spectre",
	},
}

_M["ethanholz/nvim-lastplace"] = {
	setup = {
		module = "nvim-lastplace",
		config = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
	},
}

_M["gbprod/yanky.nvim"] = {
	setup = {
		module = "yanky",
		config = {
			ring = {
				sync_with_numbered_registers = false,
			},
			highlight = {
				on_put = false,
				on_yank = false,
			},
		},
	},
	after = {
		use_telescope = function()
			require("telescope").load_extension("yank_history")
		end,
	},
}

-- merged into treesitter. check nvim-treesitter/nvim-treesitter's config.
_M["nvim-treesitter/nvim-treesitter-textobjects"] = {}

_M["folke/todo-comments.nvim"] = {
	setup = {
		module = "todo-comments",
	},
}

_M["danymat/neogen"] = {
	setup = {
		module = "neogen",
		config = {
			snippet_engine = "luasnip",
		},
	},
}

_M["numToStr/Comment.nvim"] = {
	setup = {
		module = "Comment",
	},
}

_M["rmagatti/auto-session"] = {
	setup = {
		module = "plugins.setup.auto-session",
	},
}

_M["rmagatti/session-lens"] = {
	setup = {
		module = "session-lens",
	},
}

_M["mfussenegger/nvim-dap"] = {
	setup = {
		module = "plugins.setup.dap",
	},
}

_M["Weissle/persistent-breakpoints.nvim"] = {
	setup = {
		module = "persistent-breakpoints",
		config = {
			load_breakpoints_event = { "BufReadPost" },
		},
	},
}

_M["nvim-telescope/telescope-dap.nvim"] = {
	after = {
		use_telescope = function()
			require("telescope").load_extension("dap")
		end,
	},
}

_M["theHamsta/nvim-dap-virtual-text"] = {
	setup = {
		module = "nvim-dap-virtual-text",
	},
}

_M["rcarriga/nvim-dap-ui"] = {
	setup = {
		module = "dapui",
	},
	after = {
		open_when_dap_initialized = function()
			require("dap").listeners.after.event_initialized["dapui_config"] = require("dapui").open
		end,
	},
}

_M = require("core").merge_configs(_M, "plugins.setup_config")

return _M
