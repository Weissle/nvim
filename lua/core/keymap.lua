local M = {}
local utils = require("core.utils")

M.keymap_opts = { noremap = true, silent = true }

M.get_keymap_empty_bucket = function()
	return utils.create_default_table({})
end

M.set_keymap_bucket = function(cfg)
	local opts = M.keymap_opts
	local keymap = vim.keymap.set
	for mode, tbl in pairs(cfg) do
		for ori, dst in pairs(tbl) do
			if type(dst) == "table" then
				keymap(mode, ori, dst[1], dst.opts)
			else
				keymap(mode, ori, dst, opts)
			end
		end
	end
end

return M
