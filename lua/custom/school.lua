local M = {}

local lsp_servers = {
	"pyright",
	"clangd",
	"cmake",
	"bashls",
	"sumneko_lua",
	"texlab",
}

M["plugins.plugins"] = {
	["kdheepak/cmp-latex-symbols"] = {
		after = "nvim-cmp",
	},
}

M["plugins.setup.nvim-cmp"] = function(C)
	C.cmp_source.latex_symbols = "Tex"
	table.insert(C.insert_config.sources, { name = "latex_symbols" })
	return C
end

M["plugins.setup.mason-lspconfig"] = {
	config = {
		ensure_installed = lsp_servers,
	},
}

M["plugins.setup.lspconfig"] = function(C)
	C.lsp_servers = lsp_servers
	return C
end

return M
