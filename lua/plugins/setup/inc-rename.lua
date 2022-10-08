local M = {}

local dressing_ext, _ = pcall(require, "dressing")

if dressing_ext then
	M.config = {
		input_buffer_type = "dressing",
	}
else
	M.config = {}
end

M.setup = function()
	require("inc_rename").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.inc-rename")

return M
