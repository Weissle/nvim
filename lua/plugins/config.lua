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

-- INFO: For lazy loaded.
M.lazy_event_enter_file = { "BufRead", "BufNewFile" }

M = require("core").merge_configs(M, "plugins.config")

return M
