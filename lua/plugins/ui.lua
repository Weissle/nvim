return {
	{
		"folke/tokyonight.nvim",
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd("colorscheme tokyonight")
		end,
		opts = {
			style = "moon",
			on_highlights = function(highlights, _)
				highlights.WinSeparator = {
					fg = "#6699FF",
				}
			end,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "folke/tokyonight.nvim" },
		config = function()
			local function location_info()
				local total_line = tostring(vim.api.nvim_buf_line_count(0))
				local current_line = "         " .. tostring(vim.api.nvim_win_get_cursor(0)[1])
				return string.format("%s/%s", string.sub(current_line, #current_line - #total_line), total_line)
			end

			local config = {
				options = {
					theme = "tokyonight",
					ignore_focus = {
						"NvimTree",
						"Outline",
						"dapui_console",
						"dap-repl",
						"dapui_breakpoints",
						"dapui_stacks",
						"dapui_scopes",
						"dapui_watches",
					},
				},
				sections = {
					lualine_c = { "filename" },
					lualine_z = { location_info },
				},
			}

			require("lualine").setup(config)
		end,
	},
	{
		"akinsho/bufferline.nvim",
		tag = "v3.1.0",
		config = function()
			vim.keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<cr>")
			vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>")
			vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>")
			vim.keymap.set("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<cr><C-L>")
			vim.keymap.set("n", "<leader>bcr", "<cmd>BufferLineCloseRight<cr><C-L>")
			vim.keymap.set("n", "<leader>bco", "<cmd>BufferLineCloseRight<cr><bar><cmd>BufferLineCloseLeft<cr><C-L>")
			require("bufferline").setup({
				options = {
					groups = {
						items = {
							require("bufferline.groups").builtin.ungrouped,
							{
								name = "Bash",
								auto_close = false,
								matcher = function(buf)
									return buf.buftype == "terminal"
								end,
							},
						},
					},
				},
			})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim" },
}
