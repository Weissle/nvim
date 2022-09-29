local M = {}

M.config = {
	defaults = {
		mappings = require("mappings.plugin_builtin").telescope(),
	},
}

M.load_notify = function()
	local ext, _ = pcall(require, "notify")
	if ext then
		require("telescope").load_extension("notify")
	end
end

M.load_harpoon = function()
	local ext, _ = pcall(require, "harpoon")
	if ext then
		require("telescope").load_extension("harpoon")
	end
end
M.setup = function()
	require("telescope").setup(M.config)
	M.load_notify()
	M.load_harpoon()
end

M = require("core").merge_configs(M, "plugins.setup.telescope")

return M
