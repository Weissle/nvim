-- For language c/cpp including lsp, format feature
local M = {}

M["plugins.setup.lspconfig"] = function(C)
	table.insert(C.lsp_servers, "sumneko_lua")
	C.clients_format_disabled["sumneko_lua"] = true
	C.sumneko_lua_config = {
		capabilities = C.default_capabilities,
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
		on_attach = C.on_attach,
	}
end

M["plugins.setup.null-ls"] = function(C)
	table.insert(C.config.sources, require("null-ls").builtins.formatting.stylua)
end

M["plugins.setup.treesitter"] = function(C)
	table.insert(C.config.ensure_installed, "lua")
end

require("core").register_override_config(M)
