local M = {}

M.config = {
	view = {
		adaptive_size = true,
		side = "right",
	},
	git = {
		ignore = false,
	},
}

M.setup = function()
	require("nvim-tree").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.nvim-tree")

return M
