local M = {}

M.config = {
	ring = {
		sync_with_numbered_registers = false,
	},
	highlight = {
		on_put = false,
		on_yank = false,
	},
}

M.use_telescope = function()
	require("telescope").load_extension("yank_history")
end

M.setup = function()
	require("yanky").setup(M.config)
	M.use_telescope()
end

M = require("core").merge_configs(M, "plugins.setup.yanky")

return M
