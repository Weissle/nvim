local M = {}

local action = require("telescope.actions")
M.telescope = {
	n = {
		['q'] = action.close
	},
	i = {
		['<ESC>'] = action.close
	}
}

M.cmp = {

}
return M
