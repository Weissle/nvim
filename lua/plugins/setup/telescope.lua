local M = {}

M.config = {
	defaults = {
		mappings = require("mappings.plugin_builtin").telescope(),
	},
}

M.setup = function()
	require("telescope").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.telescope")

return M
