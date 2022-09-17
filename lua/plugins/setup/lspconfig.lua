local M = {}


M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

M.sumneko_lua_config = {
	capabilities = M.capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
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
}

M.clangd_config = {
	capabilities = M.capabilities,
	cmd = { "clangd", "--header-insertion=never" },
}


M.default_lsp_config = {
	capabilities = M.capabilities,
}

M.setup = function()
	local lspconfig = require("lspconfig")
	local servers = require("gconfig").lsp_server_list
	for _, lsp in pairs(servers) do
		if M[lsp .. "_config"] == nil then
			lspconfig[lsp].setup(M.default_lsp_config)
		else
			lspconfig[lsp].setup(M[lsp .. "_config"])
		end
	end
end

return M
