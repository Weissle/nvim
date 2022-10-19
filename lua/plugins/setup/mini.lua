local M = {}
local core = require("core")

local function unhighlight_inactivate_buffer()
	vim.api.nvim_create_augroup("unhighlight_inactivate_buffer", { clear = true })
	vim.api.nvim_create_autocmd({ "BufLeave" }, {
		group = "unhighlight_inactivate_buffer",
		callback = function()
			require("mini.cursorword").auto_unhighlight()
		end,
	})
end

local function disable_cursorword_in_nvimtree()
	vim.api.nvim_create_augroup("disable_cursorword_in_nvimtree", { clear = true })
	vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
		group = "disable_cursorword_in_nvimtree",
		pattern = "NvimTree*",
		callback = function()
			vim.b.minicursorword_disable = true
		end,
	})
end

M.subplugin_config = {
	["mini.cursorword"] = {
		config = { delay = 30 },
		after = { unhighlight_inactivate_buffer, disable_cursorword_in_nvimtree },
	},
	["mini.bufremove"] = {},
	["mini.pairs"] = {},
	["mini.surround"] = {
		config = { mappings = require("mappings.plugin_builtin").mini_surround() },
	},
}

M.setup = function()
	for subplugin, cfg in pairs(M.subplugin_config) do
		core.call(cfg.preset or {})
		require(subplugin).setup(cfg.config or {})
		core.call(cfg.after or {})
	end
end

M = core.merge_configs(M, "plugins.setup.mini")

return M
