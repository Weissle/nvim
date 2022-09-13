local M = {}

M.setup = function(_)
	local nvimtree = require("nvim-tree")

	nvimtree.setup({ -- BEGIN_DEFAULT_OPTS
		view = {
			adaptive_size = true,
			side = "right",
		},
		git = {
			ignore = false,
		},
	})
end

return M
