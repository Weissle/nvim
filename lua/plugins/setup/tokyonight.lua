local M = {}

M.config = {}

M.colorscheme = "tokyonight-moon"
M.setup = function()
	require("tokyonight").setup(M.config)
	vim.cmd("colorscheme " .. M.colorscheme)
end

M = require("core").merge_configs(M, "plugins.setup.tokyonight")

return M
