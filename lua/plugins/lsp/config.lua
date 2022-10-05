local M = {}

M.lsp_servers_required = { "sumneko_lua" }

-- INFO: use stylua provided by null-ls
M.clients_format_disabled = {
	sumneko_lua = true,
}

M = require("core").merge_configs(M, "plugins.lsp.config")

return M
