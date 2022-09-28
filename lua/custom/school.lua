local M = {}

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
		ensure_installed = {
			"pyright",
			"clangd",
			"tsserver",
			"cmake",
			"bashls",
			"lemminx",
			"sumneko_lua",
			"texlab",
		},
	},
}

M["plugins.setup.lspconfig"] = function(C)
	C.lsp_servers = { "pyright", "clangd", "tsserver", "cmake", "bashls", "lemminx", "sumneko_lua", "texlab" }
	return C
end

return M
