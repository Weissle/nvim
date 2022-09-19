local M = {}

M.config = {
	on_highlights = function(highlights, colors)
		highlights.WinSeparator = {
			fg = "#6699FF",
		}
	end,
}

M.set_colorscheme = function()
	vim.cmd("colorscheme tokyonight")
end
M.setup = function()
	require("tokyonight").setup(M.config)
	M.set_colorscheme()
end

M = require("core").merge_user_config(M, "plugins.setup.tokyonight")

return M
