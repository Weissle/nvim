local M = {}

M.subplugin_config = {
	["mini.cursorword"] = {
		delay = 30,
	},
	["mini.bufremove"] = {},
	["mini.pairs"] = {},
	["mini.surround"] = {
		mappings = require("mappings.plugin_builtin").mini_surround(),
	},
}

M.setup = function()
	for subplugin, config in pairs(M.subplugin_config) do
		require(subplugin).setup(config)
	end
end

M = require("core").merge_user_config(M, "plugins.setup.mini")

return M
