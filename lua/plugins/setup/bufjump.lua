local M = {}

M.config = require("mappings.plugin_builtin").bufjump()

M.setup = function()
	require("bufjump").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.bufjump")

return M
