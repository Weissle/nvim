local M = {}

M.config = {
	config = function()
		require("nvim-lastplace").setup({
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		})
	end,
}

M.setup = function()
	require("nvim-lastplace").setup(M.config)
end

M = require("core").merge_user_config(M, "plugins.setup.nvim-lastplace")

return M
