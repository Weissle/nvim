local M = {}

M["plugins.setup.mason-lspconfig"] = function(C)
	table.insert(C.config.ensure_installed, "texlab")
end

M["plugins.setup.lspconfig"] = function(C)
	table.insert(C.lsp_servers, "texlab")
end

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
