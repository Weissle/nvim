local base = require("custom.base")
assert(type(base) == "table")

local M = vim.fn.copy(base)

M["plugins.plugins"]["kdheepak/cmp-latex-symbols"] = {
	after = "nvim-cmp",
}

M["plugins.setup.nvim-cmp"] = function(C)
	C.cmp_source.latex_symbols = "Tex"
	local insert_source = C.insert_config.sources
	insert_source[#insert_source + 1] = { name = "latex_symbols" }
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
	C = base["plugins.setup.lspconfig"](C)
	C.lsp_servers = { "pyright", "clangd", "tsserver", "cmake", "bashls", "lemminx", "sumneko_lua", "texlab" }
	return C
end

return M
