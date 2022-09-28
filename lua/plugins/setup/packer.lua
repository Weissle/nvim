local M = {}

M.ensure_packer = function()
	local packer_dir = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
	local packer_exist = not (#vim.fn.glob(packer_dir) == 0)

	if packer_exist == false then
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_dir })
		packer_exist = not (#vim.fn.glob(packer_dir) == 0)
	end

	if packer_exist == true then
		vim.cmd([[packadd packer.nvim]])
		return true
	end

	return false
end

M.init_config = {
	profile = {
		enable = true,
		threshold = 1,
	},
}

local function load_plugins(use)
	local P = require("plugins.plugins")
	for plugin_name, plugin_config in pairs(P) do
		plugin_config[1] = plugin_name
		use(plugin_config)
	end
end

M.startup_config = {
	load_plugins,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
}

M.setup = function()
	M.ensure_packer()
	require("packer").init(M.init_confing)
	require("packer").startup(M.startup_config)
end

M = require("core").merge_configs(M, "plugins.setup.packer")

return M
