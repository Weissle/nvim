local M = {}

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

M = require("core").merge_configs(M,"plugins.config")

return M


