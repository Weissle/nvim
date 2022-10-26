-- For language c/cpp including lsp, format feature
local _M = {}
_M["plugins.setup.lspconfig"] = function(C)
	table.insert(C.lsp_servers, "sumneko_lua")
	C.clients_format_disabled["sumneko_lua"] = true
	C.sumneko_lua_config = vim.deepcopy(C.default_lsp_config)
	C.sumneko_lua_config.settings = {
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
	}
end

_M["plugins.setup.null-ls"] = function(C)
	table.insert(C.config.sources, require("null-ls").builtins.formatting.stylua)
end

_M["plugins.setup_config"] = function(C)
	table.insert(C["nvim-treesitter/nvim-treesitter"].setup.config.ensure_installed, "lua")
end

require("core").register_override_config(_M)
