local M = {}

-- INFO: Disable a group of plugins at once.
M.group = {
	lsp = true,
	cmp = true,
	ui = true,
	ez = true,
	doc = true,
	session = true,
}

M.lazy_event_enter_file = { "BufRead", "BufNewFile" }

M.lsp_servers_required = { "sumneko_lua" }

M.treesitter_parsers_required = { "lua" }

-- INFO: use stylua provided by null-ls
M.clients_format_disabled = {
	sumneko_lua = true,
}

M = require("core").merge_configs(M, "plugins.config")

return M
