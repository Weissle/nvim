require("options.dev")
local _M = {}
_M["plugins.setup.lspconfig"] = function(C)
	table.insert(C.lsp_servers, "texlab")
end

_M["plugins.plugins"] = {
	["kdheepak/cmp-latex-symbols"] = {
		after = "nvim-cmp",
	},
}

_M["plugins.setup.nvim-cmp"] = function(C)
	C.cmp_source.latex_symbols = "Tex"
	table.insert(C.insert_config.sources, { name = "latex_symbols" })
end

require("core").register_override_config(_M)
