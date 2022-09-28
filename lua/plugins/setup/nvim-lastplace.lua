local M = {}

M.config = {
	lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
	lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
	lastplace_open_folds = true,
}

M.setup = function()
	require("nvim-lastplace").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.nvim-lastplace")

return M
