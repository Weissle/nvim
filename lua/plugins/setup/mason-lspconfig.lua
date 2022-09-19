local M = {}

M.config = { ensure_installed = "sumnko_lua" }

M.setup = function()
	require("mason-lspconfig").setup(M.config)

	M = require("core").merge_user_config(M, "plugins.setup.mason-lspconfig")
end
