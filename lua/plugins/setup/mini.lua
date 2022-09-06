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
		mappings = require("mappings.pl_mappings").mini_surround(),
	})
end

return M
