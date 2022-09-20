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

M.unhighlight_inactivate_buffer = function()
	vim.api.nvim_create_augroup("unhighlight_inactivate_buffer", { clear = true })
	vim.api.nvim_create_autocmd({ "BufLeave" }, {
		callback = function()
			require("mini.cursorword").auto_unhighlight()
		end,
	})
end

M.setup = function()
	for subplugin, config in pairs(M.subplugin_config) do
		require(subplugin).setup(config)
	end
	M.unhighlight_inactivate_buffer()
end

M = require("core").merge_user_config(M, "plugins.setup.mini")

return M
