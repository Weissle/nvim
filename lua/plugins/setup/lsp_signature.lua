local M = {}
local core = require("core")

M.config = {
	bind = true,
	handler_opts = {
		border = "rounded",
	},
	floating_window = false,
}

M.setup = function()
	require("lsp_signature").setup(M.config)
end

M = core.merge_configs(M, "plugins.setup.lsp_signature")

return M
