local M = {}

M.config = {
	-- A list of parser names, or "all"
	ensure_installed = { "c", "lua", "cpp", "json", "python", "cmake", "markdown" },
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	highlight = {
		-- `false` will disable the whole extension
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

M = require("core").merge_user_config(M, "plugins.setup.treesitter")

return M
