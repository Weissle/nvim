local M = {}

M["plugins.plugins"] = {

	["lewis6991/impatient.nvim"] = nil,

	["iamcco/markdown-preview.nvim"] = {
		ft = { "markdown" },
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_open_to_the_world = 1
		end,
	},

	["kdheepak/cmp-latex-symbols"] = {
		event = { "InsertEnter" },
	},

	["williamboman/mason-lspconfig.nvim"] = {
		config = function()
			require("mason-lspconfig").setup({
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
			})
		end,
	},
}

M["plugins.setup.luasnip"] = {
	load_snippets = function()
		require("luasnip.loaders.from_vscode").lazy_load({
			exclude = { "cpp" },
		})
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { "./snippets" },
		})
	end,
}

M["plugins.setup.nvim-cmp"] = function(C)
	C.cmp_source.latex_symbols = "Tex"
	local insert_source = C.insert_config.sources
	insert_source[#insert_source + 1] = { name = "latex_symbols" }
	return C
end

M["plugins.setup.treesitter"] = function(C)
	C.config.ensure_installed = { "c", "lua", "cpp", "json", "python", "cmake", "markdown" }
	return C
end

M["plugins.setup.lspconfig"] = {
	servers = { "pyright", "clangd", "tsserver", "cmake", "bashls", "lemminx", "sumneko_lua", "texlab" },
	clangd_config = {
		capabilities = M.capabilities,
		cmd = { "clangd", "--header-insertion=never" },
	},
}
return M
