local M = {}

M.setup = function(_)
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = require("mappings.pl_mappings").telescope(),
		},
	})
	telescope.load_extension("notify")
end

return M
