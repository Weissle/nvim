local M = {}
local gcfg = require("gconfig")

M["plugins.plugins"] = function(C)
	C["lewis6991/impatient.nvim"] = {
		disable = true,
	}

	C["iamcco/markdown-preview.nvim"] = {
		ft = { "markdown" },
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_open_to_the_world = 1
		end,
	}

	C["kdheepak/cmp-latex-symbols"] = {
		event = gcfg.lazy_event_start_insert,
	}

	return C
end

M["plugins.setup.luasnip"] = function(C)
	C.load_snippets = function()
		require("luasnip.loaders.from_vscode").lazy_load({
			exclude = { "cpp" },
		})
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { "./snippets" },
		})
	end

	return C
end

M["plugins.setup.nvim-cmp"] = function(C)
	C.cmp_source.latex_symbols = "Tex"
	local insert_source = C.insert_config.sources
	insert_source[#insert_source + 1] = { name = "latex_symbols" }
	return C
end

return M
