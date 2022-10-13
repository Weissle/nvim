local M = {}

M["plugins.setup.treesitter"] = function(C)
	table.insert(C.config.ensure_installed, "json")
	table.insert(C.config.ensure_installed, "markdown")
end

M["plugins.setup.lspconfig"] = function(C)
	C.clangd_config = {
		capabilities = C.default_capabilities,
		on_attach = C.on_attach,
		cmd = { "clangd", "--header-insertion=never" },
	}
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

M["mappings.init"] = function(C)
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

	C["n"]["gcp"] = "yygccp"
	C["n"]["gcP"] = "yygccP"
end

M["plugins.setup.telescope"] = function(C)
	C.config.defaults.path_display = {
		shorten = {
			len = 5,
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

M["settings.opt"] = {
	mouse = "",
}

return M
