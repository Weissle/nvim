local M = {}

M.config = {
	resize_mode = {
		hooks = {
			on_enter = function()
				vim.api.nvim_del_augroup_by_name("move-to-term")
			end,
			on_leave = function()
				local f = require("settings.functions").setup_startinsert_in_terminal
				if type(f) == "function" then
					f()
				end
			end,
		},
	},
}

M.setup = function()
	require("smart-splits").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.smart-splits")

return M
