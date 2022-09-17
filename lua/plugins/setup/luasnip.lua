local M = {}

M.config = {
	region_check_events = "InsertEnter",
}

M.load_snippets = function()
	require("luasnip.loaders.from_vscode").lazy_load({})
end

M.setup = function()
	require("luasnip").setup(M.config)
	M.load_snippets()
end

M = require("core").merge_user_config(M, "plugins.setup.luasnip")

return M
