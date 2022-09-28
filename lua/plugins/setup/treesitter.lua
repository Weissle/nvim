local M = {}

M.config = {
	ensure_installed = { "lua" },
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

M.prefer_git = function()
	require("nvim-treesitter.install").prefer_git = true
end

M.setup = function()
	require("nvim-treesitter.configs").setup(M.config)
	M.prefer_git()
end

M = require("core").merge_configs(M, "plugins.setup.treesitter")

return M
