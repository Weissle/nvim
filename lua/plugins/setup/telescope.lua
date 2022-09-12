local M = {}

M.setup = function(_)
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = require("mappings.pl_mappings").telescope(),
		},
	})
	local ext, _ = pcall(require, "notify")
	if ext then
		telescope.load_extension("notify")
	end
end

return M
