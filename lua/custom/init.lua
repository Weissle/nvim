local M = {}

local create_empty_function = function(ret)
	return function(...)
		return ret
	end
end

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

M["plugins.setup.mini"] = {
	set_cursorword_highlight = create_empty_function(nil)
}

M["mappings.mappings"] = function (C)

	C["n"]["<F3>"] = "<cmd>noh<cr>"
	C["i"]["<C-h>"] = "<left>"
	C["i"]["<C-l>"] = "<right>"
	C["i"]["<C-k>"] = "<up>"
	C["i"]["<C-j>"] = "<down>"
	C[""]["J"] = "gJ"

	C["t"]["<C-w><C-j>"] = "<C-\\><C-n><C-w>j"
	C["t"]["<C-w><C-h>"] = "<C-\\><C-n><C-w>h"
	C["t"]["<C-w><C-k>"] = "<C-\\><C-n><C-w>k"
	C["t"]["<C-w><C-l>"] = "<C-\\><C-n><C-w>l"
	C["t"]["<leader>qt"] = "<cmd>q<cr>"
	C["t"]["<leader>qq"] = "exit<cr>"
	--> Quit or Close
	C["n"]["<leader>qq"] = "<cmd>wq<cr>"
	--> so long due to the bug of terminal mode
	C["n"]["<leader>qa"] = "<cmd>wa<cr><bar><cmd>qa<cr>"
	C["n"]["<leader>qt"] = "<cmd>q<cr>"
	C["n"]["<leader>qw"] = "<cmd>wa<cr>"

end

return M
