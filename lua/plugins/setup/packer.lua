local M = {}

local function load_plugins(use)
	M = require("plugins.plugins")
	for plugin_name, plugin_config in pairs(M) do
		plugin_config[1] = plugin_name
		use(plugin_config)
	end
end

M.setup = function(_)
	vim.cmd("packadd packer.nvim")
	require("packer").init({
		profile = {
			enable = true,
			threshold = 1,
		},
	})
	vim.cmd([[
	augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
	]])

	require("packer").startup({
		load_plugins,
		config = {
			display = {
				open_fn = function()
					return require("packer.util").float({ border = "single" })
				end,
			},
		},
	})
end

return M
