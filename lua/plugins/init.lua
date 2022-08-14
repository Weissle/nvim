local packer_bootstrap = nil

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap =
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

require("packer").init({
	profile = {
		enable = true,
		threshold = 1,
	},
})

local function load_plugins(use)
	M = require("plugins.plugins")
	for plugin_name, plugin_config in pairs(M) do
		plugin_config[1] = plugin_name
		use(plugin_config)
	end

	if packer_bootstrap then
		require("packer").sync({})
	end
end

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
