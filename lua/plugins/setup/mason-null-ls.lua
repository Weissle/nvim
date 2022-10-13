local M = {}

M.config = { automatic_installation = true }

M.setup = function()
	require("mason-null-ls").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.mason-null-ls")

return M
