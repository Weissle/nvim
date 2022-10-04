local M = {}
local core = require("core")
local nl = require("null-ls")
local builtins = nl.builtins

M.config = {
	sources = {
		builtins.formatting.stylua,
	},
}

M.setup = function()
	nl.setup(M.config)
end

M = core.merge_configs(M, "plugins.setup.null-ls")

return M
