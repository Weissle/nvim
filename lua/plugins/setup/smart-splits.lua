local M = {}

M.setup = function(_)
	require("smart-splits").setup({
		resize_mode = {
			hooks = {
				on_enter = function()
					vim.api.nvim_del_augroup_by_name("move-to-term")
				end,
				-- HACK: is not called
				on_leave = function()
					require("common").enter_term_autocmd()
				end,
			},
		},
	})
end

return M
