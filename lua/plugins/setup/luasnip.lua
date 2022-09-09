local M = {}

M.setup = function(_)
	require("luasnip").setup({
		region_check_events = "InsertEnter",
	})
	-- load friendly-snippets
	require("luasnip.loaders.from_vscode").lazy_load({
		exclude = { "cpp" },
	})
	-- load my snippets
	require("luasnip.loaders.from_vscode").lazy_load({
		paths = { "./snippets" },
	})
end

return M
