local M = {}

M.config = {
	style = "moon",
	on_highlights = function(highlights, colors)
		highlights.WinSeparator = {
			fg = "#6699FF",
		}
	end,
}

M.setup = function()
	require("tokyonight").setup(M.config)
	vim.cmd("colorscheme tokyonight")
end

M = require("core").merge_configs(M, "plugins.setup.tokyonight")

return M
