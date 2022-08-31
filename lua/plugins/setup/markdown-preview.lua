local M = {}
-- Utility functions shared between progress reports for LSP and DAP

M.setup = function(_)
	local g = vim.g
	g.mkdp_auto_close = 0
	g.mkdp_open_to_the_world = 1
end

return M
