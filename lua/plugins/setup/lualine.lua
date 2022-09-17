local M = {}

local function location_info()
	local total_line = tostring(vim.api.nvim_buf_line_count(0))
	local current_line = "         " .. tostring(vim.api.nvim_win_get_cursor(0)[1])
	return string.format("%s/%s", string.sub(current_line, #current_line - #total_line), total_line)
end

M.config = {
	options = {
		theme = require("gconfig").colorscheme,
		ignore_focus = {
			"NvimTree",
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

M.setup = function()
	require("lualine").setup(M.config)
end

return M
