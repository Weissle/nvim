local M = {}

M.config = {
	resize_mode = {
		hooks = {
			on_enter = function()
				vim.api.nvim_del_augroup_by_name("move-to-term")
			end,
			on_leave = function()
				require("settings.functions").setup_startinsert_in_terminal()
			end,
		},
	},
}

M.setup = function()
	require("smart-splits").setup(M.config)
end

M = require("core").merge_user_config(M, "plugins.setup.smart-splits")

return M
