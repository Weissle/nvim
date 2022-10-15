local M = {}
local core = require("core")

M.lsp_servers = { "sumneko_lua", "pyright", "clangd", "bashls", "cmake" }

-- null-ls provides the format feature.
M.clients_format_disabled = {
	sumneko_lua = true,
	clangd = true,
}

local cmp_nvim_lsp_ext, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ext then
	M.default_capabilities = require("cmp_nvim_lsp").default_capabilities()
else
	M.default_capabilities = vim.lsp.protocol.make_client_capabilities()
end

M.on_attach = function(client, bufnr)
	-- client.offset_encoding = "utf-8"
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

M.load_lua_dev = function()
	local lua_dev_ext, lua_dev = pcall(require, "neodev")
	if lua_dev_ext then
		lua_dev.setup({})
	end
end

M.setup = function()
	M.load_lua_dev()
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
