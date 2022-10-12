local M = {}
local core = require("core")
local nl = require("null-ls")
local builtins = nl.builtins

M.config = {
	sources = {
		builtins.formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if _G._client_offset_encodings == nil then
			if core.vim_version >= "0.8.0" then
				_G._client_offset_encoding = client.server_capabilities.offsetEncoding
			else
				_G._client_offset_encoding = client.resolved_capabilities.offset_encoding
			end
		else
			if core.vim_version >= "0.8.0" then
				client.server_capabilities.offsetEncodings = _G._client_offset_encoding
			else
				client.resolved_capabilities.offset_encodings = _G._client_offset_encoding
			end
		end

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
