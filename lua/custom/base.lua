local M = {}

M["plugins.setup.treesitter"] = function(C)
	C.config.ensure_installed = { "c", "lua", "cpp", "json", "python", "cmake", "markdown" }
end

M["plugins.setup.lsp.config"] = function(C)
	C.lsp_servers_required = {
		"pyright",
		"clangd",
		"cmake",
		"bashls",
		"sumneko_lua",
	}
	C.clients_format_disabled["clangd"] = true
end

M["plugins.setup.lsp.null-ls"] = function(C)
	local formatting = require("null-ls").builtins.formatting
	table.insert(C.config.sources, formatting.clang_format)
end

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

M["plugins.setup.lsp.lspconfig"] = function(C)
	C.clangd_config = vim.deepcopy(C.default_lsp_config)
	C.clangd_config.cmd = { "clangd", "--header-insertion=never" }
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
end

M["plugins.setup.telescope"] = function(C)
	C.config.defaults.path_display = {
		shorten = {
			len = 3,
			exclude = { 1, -1 },
		},
	}
end

M["plugins.setup.nvim-tree"] = function(C)
	C.config.view = {
		adaptive_size = true,
		side = "right",
	}
end

return M
