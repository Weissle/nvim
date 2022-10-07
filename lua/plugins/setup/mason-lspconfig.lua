local M = {}

M.config = { automatic_installation = true }

M.setup = function()
	require("mason-lspconfig").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.mason-lspconfig")

return M
