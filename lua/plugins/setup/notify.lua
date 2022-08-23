local M = {}
-- Utility functions shared between progress reports for LSP and DAP

M.setup = function(_)
	local notify = require("notify")
	vim.notify = notify
	require("telescope").load_extension("notify")
end

return M
