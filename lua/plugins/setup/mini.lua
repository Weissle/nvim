local M = {}
local core = require("core")

M.unhighlight_inactivate_buffer = function()
	vim.api.nvim_create_augroup("unhighlight_inactivate_buffer", { clear = true })
	vim.api.nvim_create_autocmd({ "BufLeave" }, {
		callback = function()
			require("mini.cursorword").auto_unhighlight()
		end,
	})
end

M.subplugin_config = {
	["mini.cursorword"] = {
		config = { delay = 30 },
		after = { M.unhighlight_inactivate_buffer },
	},
	["mini.bufremove"] = {},
	["mini.pairs"] = {},
	["mini.surround"] = {
		config = { mappings = require("mappings.plugin_builtin").mini_surround() },
	},
}

M.setup = function()
	for subplugin, cfg in pairs(M.subplugin_config) do
		core.call(cfg.preset or {})
		require(subplugin).setup(cfg.config)
		core.call(cfg.after or {})
	end
end

M = require("core").merge_configs(M, "plugins.setup.mini")

return M
