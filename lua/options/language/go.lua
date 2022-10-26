-- For language golang.

local _M = {}
_M["plugins.setup.lspconfig"] = function(C)
	table.insert(C.lsp_servers, "gopls")
end

_M["plugins.setup_config"] = function(C)
	table.insert(C["nvim-treesitter/nvim-treesitter"].setup.config.ensure_installed, "go")
end

require("core").register_override_config(_M)
