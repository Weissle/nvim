local M = {}

local function location_info()
	local total_line = tostring(vim.api.nvim_buf_line_count(0))
	local current_line = tostring(vim.api.nvim_win_get_cursor(0)[1])
	while #current_line < #total_line do
		current_line = string.format(" %s", current_line)
	end
	return string.format("%s/%s", current_line, total_line)
end

M.setup = function(_)
	require("lualine").setup({
		options = {
			theme = "tokyonight",
			ignore_focus = {
				"NvimTree",
				"dapui_console",
				"dap-repl",
				"dapui_breakpoints",
				"dapui_stacks",
				"dapui_scopes",
				"dapui_watches",
			},
			globalstatus = true
		},
		sections = {
			lualine_c = {'filename'},
			lualine_z = { location_info },
		},
	})
end

return M
