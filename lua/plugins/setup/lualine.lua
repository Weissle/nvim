local M = {}

M.location_info = function()
	local total_line = tostring(vim.api.nvim_buf_line_count(0))
	local current_line = "         " .. tostring(vim.api.nvim_win_get_cursor(0)[1])
	return string.format("%s/%s", string.sub(current_line, #current_line - #total_line), total_line)
end

M.config = {
	options = {
		theme = "tokyonight",
		ignore_focus = {
			"NvimTree",
			"Outline",
		},
	},
	sections = {
		lualine_c = { "filename" },
		lualine_z = { M.location_info },
	},
}

M.setup = function()
	require("lualine").setup(M.config)
end

M = require("core").merge_user_config(M, "plugins.setup.lualine")

return M
