local M = {}

M.config = { ensure_installed = require("plugins.setup.lsp.config").lsp_servers_required }

M.setup = function()
	require("mason-lspconfig").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.lsp.mason-lspconfig")

return M
