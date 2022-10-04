local M = {}
local pcfg = require("plugins.config")

local ext, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- INFO: Change default_capabilities will not effect other variables which alread directly use default_capabilities like default_lsp_config.
if ext then
	M.default_capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
else
	M.default_capabilities = vim.lsp.protocol.make_client_capabilities()
end

M.on_attach = function(client, bufnr)
	if pcfg.clients_format_disabled[client.name] ~= nil then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

M.sumneko_lua_config = {
	capabilities = M.default_capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
			completion = {
				autoRequire = false,
				keywordSnippet = "Disable",
				callSnippet = "Replace",
			},
		},
	},
	on_attach = M.on_attach,
}

M.default_lsp_config = {
	capabilities = M.default_capabilities,
	on_attach = M.on_attach,
}

M.lsp_servers = require("plugins.config").lsp_servers_required

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
