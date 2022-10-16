local M = {}
local core = require("core")

M.lsp_servers = {}

-- if null-ls provides the format feature.
M.clients_format_disabled = {}

local cmp_nvim_lsp_ext, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local default_capabilities
if cmp_nvim_lsp_ext then
	default_capabilities = cmp_nvim_lsp.default_capabilities()
else
	default_capabilities = vim.lsp.protocol.make_client_capabilities()
end

M.default_lsp_config = {
	capabilities = default_capabilities,
	on_attach = function(client, bufnr)
		if core.vim_version >= "0.8.0" then
			if M.clients_format_disabled[client.name] ~= nil then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end
		else
			if M.clients_format_disabled[client.name] ~= nil then
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
			end
		end
	end,
}

M.setup = function()
	local lspconfig = require("lspconfig")
	for _, lsp in pairs(M.lsp_servers) do
		if M[lsp .. "_config"] == nil then
			lspconfig[lsp].setup(M.default_lsp_config)
		else
			lspconfig[lsp].setup(M[lsp .. "_config"])
		end
	end
end

M = require("core").merge_configs(M, "plugins.setup.lspconfig")

return M
