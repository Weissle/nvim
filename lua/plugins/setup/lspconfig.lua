local M = {}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

M.sumneko_lua_config = {
	capabilities = capabilities,
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
}

M.default_lsp_config = {
	capabilities = capabilities,
}

M.lsp_servers = { "sumneko_lua" }

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

M = require("core").merge_user_config(M, "plugins.setup.lspconfig")

return M
