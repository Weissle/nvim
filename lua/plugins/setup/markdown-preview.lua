local M = {}

M.setup = function()
	vim.g.mkdp_auto_close = 0
	vim.g.mkdp_open_to_the_world = 1
end

M = require("core").merge_user_config(M, "plugins.setup.markdown-preview")

return M
