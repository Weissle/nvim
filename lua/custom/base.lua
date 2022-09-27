local M = {}

M["plugins.plugins"] = {

	["lewis6991/impatient.nvim"] = {
		disable = true,
	},

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

}

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
		},
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

M["plugins.setup.treesitter"] = function(C)
	C.config.ensure_installed = { "c", "lua", "cpp", "json", "python", "cmake", "markdown"} 
	return C
end

M["plugins.setup.lspconfig"] = function(C)
	C.lsp_servers = { "pyright", "clangd", "tsserver", "cmake", "bashls", "lemminx", "sumneko_lua"}
	C.clangd_config = {
		capabilities = C.default_capabilites,
		cmd = { "clangd", "--header-insertion=never" },
	}
	return C
end

M["mappings.mappings"] = function(C)
	C["n"]["<F3>"] = "<cmd>noh<cr>"
	C[""]["J"] = "gJ"

	C["t"]["<C-w><C-j>"] = "<C-\\><C-n><C-w>j"
	C["t"]["<C-w><C-h>"] = "<C-\\><C-n><C-w>h"
	C["t"]["<C-w><C-k>"] = "<C-\\><C-n><C-w>k"
	C["t"]["<C-w><C-l>"] = "<C-\\><C-n><C-w>l"
	C["t"]["<leader>qt"] = "<cmd>q<cr>"
	C["t"]["<leader>qq"] = "exit<cr>"

	--> so long due to the bug of terminal mode
	C["n"]["<leader>qa"] = "<cmd>wa<cr><bar><cmd>qa<cr>"
	C["n"]["<leader>qt"] = "<cmd>q<cr>"
	C["n"]["<leader>qw"] = "<cmd>wa<cr>"

	return C
end

M["plugins.setup.telescope"] = function(C)
	C.config.defaults.path_display = {
		shorten = {
			len = 3,
			exclude = { 1, -1 },
		},
	}
	return C
end

return M
