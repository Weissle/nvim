-- For language golang.

local _M = {}
_M["plugins.setup.lspconfig"] = function(C)
	table.insert(C.lsp_servers, "gopls")
end

_M["plugins.setup.treesitter"] = function(C)
	table.insert(C.config.ensure_installed, "go")
end

require("core").register_override_config(_M)
