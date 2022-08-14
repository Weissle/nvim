local M = {}

M.setup = function (_)
	local ext,nvimtree = pcall(require, 'nvim-tree')
	if not ext then
		return
	end

	nvimtree.setup { -- BEGIN_DEFAULT_OPTS
	git = {
		ignore = false,
	},
}
end

return M
