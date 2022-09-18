local M = {}

local telescope = require("telescope")

M.config = {
	defaults = {
		mappings = require("mappings.plugin_builtin").telescope(),
	},
}

M.load_notify = function()
	local ext, _ = pcall(require, "notify")
	if ext then
		telescope.load_extension("notify")
	end
end

M.setup = function()
	telescope.setup(M.config)
	M.load_notify()
end

M = require("core").merge_user_config(M, "plugins.setup.telescope")

return M
