return {
	-- R["lewis6991/impatient.nvim"] = {}
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFocus" },
		name = "nvim-tree",
		opts = {
			git = {
				ignore = false,
			},
			view = {
				adaptive_size = true,
				side = "right",
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		-- event = { "BufRead", "BufNewFile", "InsertEnter" },
		config = function(_, opts)
			require("luasnip").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load({
				exclude = { "all", "cpp" },
			})
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "./snippets" },
			})
		end,
		opts = {
			region_check_events = "InsertEnter",
		},
	},
	{
		"williamboman/mason.nvim",
		name = "mason",
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		name = "telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			local action = require("telescope.actions")
			local cfg = {
				defaults = {
					mappings = {
						n = {
							["q"] = action.close,
						},
						i = {
							["<ESC>"] = action.close,
						},
					},
					path_display = {
						shorten = {
							len = 5,
							exclude = { 1, -1 },
						},
					},
				},
			}
			require("telescope").setup(cfg)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
	},
	{
		"rcarriga/nvim-notify",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function(_, opts)
			require("notify").setup(opts)
			require("telescope").load_extension("notify")
		end,
		opts = { level = vim.log.levels.WARN },
	},
	{
		"karb94/neoscroll.nvim",
		name = "neoscroll",
		keys = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" },
		opts = { mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" } },
	},
	{
		"phaazon/hop.nvim",
		name = "hop",
		opts = {},
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			local M = {}

			local function unhighlight_inactivate_buffer()
				vim.api.nvim_create_augroup("unhighlight_inactivate_buffer", { clear = true })
				vim.api.nvim_create_autocmd({ "BufLeave" }, {
					group = "unhighlight_inactivate_buffer",
					callback = function()
						require("mini.cursorword").auto_unhighlight()
					end,
				})
			end

			local function disable_cursorword_in_nvimtree()
				vim.api.nvim_create_augroup("disable_cursorword_in_nvimtree", { clear = true })
				vim.api.nvim_create_autocmd({ "Filetype" }, {
					group = "disable_cursorword_in_nvimtree",
					pattern = "NvimTree",
					callback = function()
						vim.b.minicursorword_disable = true
					end,
				})
			end

			local function create_bufremove_command()
				vim.api.nvim_create_user_command("BufDelete", function()
					require("mini.bufremove").delete(0, false)
				end, {})
				vim.api.nvim_create_user_command("BufDeleteForce", function()
					require("mini.bufremove").delete(0, true)
				end, {})
			end

			M.subplugin_config = {
				["mini.cursorword"] = {
					config = { delay = 30 },
					after = { unhighlight_inactivate_buffer, disable_cursorword_in_nvimtree },
				},
				["mini.bufremove"] = {
					after = { create_bufremove_command },
				},
				["mini.pairs"] = {},
				["mini.surround"] = {
					config = {
						mappings = {
							add = "<leader>as",
							delete = "ds",
							find = "",
							find_left = "",
							highlight = "",
							replace = "cs",
							update_n_lines = "",
						},
					},
				},
				["mini.doc"] = {},
			}

			M.setup = function()
				for subplugin, cfg in pairs(M.subplugin_config) do
					require(subplugin).setup(cfg.config or {})
					if cfg.after then
						for k, v in ipairs(cfg.after) do
							v()
						end
					end
				end
			end

			M.setup()
		end,
	},
	{
		"kevinhwang91/promise-async",
		lazy = true,
	},
	{
		"mrjones2014/smart-splits.nvim",
		cmd = "SmartResizeMode",
		config = true,
	},
	{
		"gbprod/yanky.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
			{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
			{ "<c-n>", "<Plug>(YankyCycleForward)" },
			{ "<c-p>", "<Plug>(YankyCycleBackward)" },
			{ "<leader>fy", "<cmd>Telescope yank_history<cr>" },
		},
		config = function(_, opts)
			require("yanky").setup(opts)
			require("telescope").load_extension("yank_history")
		end,
		opts = {
			ring = {
				sync_with_numbered_registers = false,
			},
			highlight = {
				on_put = false,
				on_yank = false,
			},
		},
	},
	{
		"Weissle/easy-action",
		branch = "dev",
		dependencies = { "kevinhwang91/promise-async" },
		opts = {},
	},
	{
		"rmagatti/auto-session",
		name = "auto-session",
		cond = function()
			return vim.g.auto_session_enabled ~= false
		end,
		config = function()
			_G.close_all_floating_wins = function()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local config = vim.api.nvim_win_get_config(win)
					if config.relative ~= "" then
						vim.api.nvim_win_close(win, true)
					end
				end
			end

			_G.close_symbols_outline = function()
				pcall(vim.cmd, "tabdo SymbolsOutlineClose")
			end

			_G.close_nvim_tree = function()
				pcall(vim.cmd, "tabdo NvimTreeClose")
			end

			_G.close_dapui = function()
				local dapui_ext, dapui = pcall(require, "dapui")
				if dapui_ext == false then
					return
				else
					pcall(dapui.close, {})
				end
			end

			-- NOTE: folds options is exclusive. Due to ufo is not loaded at startup.
			vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/" },
				pre_save_cmds = {
					_G.close_nvim_tree,
					_G.close_all_floating_wins,
					_G.close_symbols_outline,
					_G.close_dapui,
				},
			})
		end,
	},
	{
		"rmagatti/session-lens",
		dependencies = { "nvim-telescope/telescope.nvim", "rmagatti/auto-session" },
		name = "session-lens",
		opts = {},
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_open_to_the_world = 1
		end,
	},
	{
		"cbochs/portal.nvim",
		keys = {
			{
				"<leader>bo",
				function()
					require("portal").jump_backward()
				end,
			},
			{
				"<leader>bi",
				function()
					require("portal").jump_forward()
				end,
			},
		},
		name = "portal",
		opts = {},
	},
}
