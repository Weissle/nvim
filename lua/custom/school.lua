local M = {}

M["plugins.lsp.config"] = {
	lsp_servers_required = {
		"pyright",
		"clangd",
		"cmake",
		"bashls",
		"sumneko_lua",
		"texlab",
	},
}

M["plugins.plugins"] = {
	["kdheepak/cmp-latex-symbols"] = {
		after = "nvim-cmp",
	},
}

M["plugins.setup.nvim-cmp"] = function(C)
	C.cmp_source.latex_symbols = "Tex"
	table.insert(C.insert_config.sources, { name = "latex_symbols" })
end

return M
