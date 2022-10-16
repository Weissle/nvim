local M = {}
local core = require("core")
local nl = require("null-ls")
local builtins = nl.builtins

M.config = {
	sources = {},
	on_attach = function(client, bufnr)
		-- client.offset_encoding = "utf-8"
		if core.vim_version >= "0.8.0" then
			client.server_capabilities.completionProvider = false
		else
			client.resolved_capabilities.completionProvider = false
		end
	end,
}

M.setup = function()
	nl.setup(M.config)
end

M = core.merge_configs(M, "plugins.setup.null-ls")

return M
