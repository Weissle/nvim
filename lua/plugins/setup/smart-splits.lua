local M = {}

M.config = {}
M.setup = function()
	require("smart-splits").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.smart-splits")

return M
