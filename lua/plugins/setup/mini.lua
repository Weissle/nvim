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
	vim.api.nvim_create_autocmd({ "Filetype" }, {
		group = "disable_cursorword_in_nvimtree",
		pattern = "NvimTree",
		callback = function()
			vim.b.minicursorword_disable = true
		end,
	})
end

local function create_bufremove_command()
	vim.api.nvim_create_user_command("BufDelete", function()
		require("mini.bufremove").delete(0, false)
	end, {})
	vim.api.nvim_create_user_command("BufDeleteForce", function()
		require("mini.bufremove").delete(0, true)
	end, {})
end

M.subplugin_config = {
	["mini.cursorword"] = {
		config = { delay = 30 },
		after = { unhighlight_inactivate_buffer, disable_cursorword_in_nvimtree },
	},
	["mini.bufremove"] = {
		after = { create_bufremove_command },
	},
	["mini.pairs"] = {},
	["mini.surround"] = {
		config = { mappings = require("mappings.plugin_builtin").mini_surround() },
	},
	["mini.doc"] = {},
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
