require("options.terminal_mode")
require("options.language.c_cpp")
require("options.language.python")
require("options.plugins.inc-rename")

local core = require("core")
local _M = {}

_M["plugins.setup.lspconfig"] = function(C)
	C.clangd_config = vim.deepcopy(C.default_lsp_config)
	C.clangd_config.cmd = {
		"clangd",
		"--header-insertion=never",
	}
end

_M["plugins.plugins"] = {
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

	["kwkarlwang/bufjump.nvim"] = {
		keys = { "<leader>bo", "<leader>bi" },
		config = function()
			require("bufjump").setup({
				forward = "<leader>bi",
				backward = "<leader>bo",
			})
		end,
	},

	["karb94/neoscroll.nvim"] = {
		disable = false,
		keys = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" },
		config = function()
			require("neoscroll").setup({ mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "<C-b>", "<C-f>" } })
		end,
	},
}

_M["mappings.base"] = function(C)
	C["n"]["<F3>"] = "<cmd>noh<cr>"
	C[""]["J"] = "gJ"

	C["t"]["<C-w><C-j>"] = "<C-\\><C-n><C-w>j"
	C["t"]["<C-w><C-h>"] = "<C-\\><C-n><C-w>h"
	C["t"]["<C-w><C-k>"] = "<C-\\><C-n><C-w>k"
	C["t"]["<C-w><C-l>"] = "<C-\\><C-n><C-w>l"

	C[{ "t", "n" }]["<leader>qt"] = "<cmd>q<cr>"
	C["n"]["<leader>qa"] = "<cmd>qa<cr>"
	C["n"]["<leader>qw"] = "<cmd>w<cr>"
	C["n"]["<leader>qW"] = "<cmd>wa<cr>"

	C["n"]["gcp"] = { "yygccp", opts = {
		remap = true,
		silent = true,
		unique = true,
	} }
	C["n"]["gcP"] = { "yygccP", opts = {
		remap = true,
		silent = true,
		unique = true,
	} }
end

_M["plugins.setup_config"] = function(C)
	C["kyazdani42/nvim-tree.lua"].setup.config.view.side = "right"
	C["nvim-telescope/telescope.nvim"].setup.config.defaults.path_display = {
		shorten = {
			len = 5,
			exclude = { 1, -1 },
		},
	}
	for _, lang in pairs({ "json", "markdown", "bash", "cmake" }) do
		table.insert(C["nvim-treesitter/nvim-treesitter"].setup.config.ensure_installed, lang)
	end
	C["L3MON4D3/LuaSnip"].after.load_snippets = function()
		require("luasnip.loaders.from_vscode").lazy_load({
			exclude = { "cpp" },
		})
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { "./snippets" },
		})
	end
end

_M["settings.opt"] = {
	mouse = "",
}

_M["settings.functions"] = function(C)
	C.setup_markdown_spell_check = function()
		vim.api.nvim_create_autocmd({ "Filetype" }, {
			pattern = "markdown",
			callback = function()
				vim.cmd([[setlocal spell]])
			end,
		})
	end
	C.setup_quickfix_q_quit = function()
		vim.api.nvim_create_autocmd({ "Filetype" }, {
			pattern = "qf",
			callback = function()
				vim.cmd([[nnoremap <buffer> q <cmd>q<cr>]])
			end,
		})
	end
end

core.register_override_config(_M)
