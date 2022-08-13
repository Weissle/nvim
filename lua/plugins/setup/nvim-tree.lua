local M = {}

M.setup = function (_)
	local ext,nvimtree = pcall(require, 'nvim-tree')

	nvimtree.setup { -- BEGIN_DEFAULT_OPTS
	git = {
		ignore = false,
	},
}
end

return M
