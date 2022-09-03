local M = {}
M.setup = function(_)
	require("mini.cursorword").setup({
		delay = 30,
	})
	vim.cmd([[
	:hi MiniCursorword gui=NONE guifg=NONE guibg=#41497D
	:hi MiniCursorwordCurrent gui=NONE guifg=NONE guibg=#41497D
	]])
	require("mini.bufremove").setup({})
	require("mappings.fl_mappings").bufremove()
	require("mini.pairs").setup({})
	require("mini.surround").setup({
		mappings = {
			add = "ys",
			delete = "ds",
			find = "",
			find_left = "",
			highlight = "",
			replace = "cs",
			update_n_lines = "",
		},
	})
end

return M
