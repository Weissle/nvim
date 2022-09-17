local M = {}

M.subplugin_config = {
	["mini.cursorword"] = {
		delay = 30,
	},
	["mini.bufremove"] = {},
	["mini.pairs"] = {},
	["mini.surround"] = {
		mappings = require("mappings.plugin_builtin").mini_surround(),
	},
}

M.set_cursorword_highlight = function()
	vim.cmd([[
	:hi MiniCursorword gui=NONE guifg=NONE guibg=#41497D
	:hi MiniCursorwordCurrent gui=NONE guifg=NONE guibg=#41497D
	]])
end

M.setup = function()
	for subplugin, config in pairs(M.subplugin_config) do
		require(subplugin).setup(config)
	end

	if M.subplugin_config["mini.cursorword"] ~= nil then
		M.set_cursorword_highlight()
	end
end

return M
