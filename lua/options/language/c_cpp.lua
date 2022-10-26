-- For language c/cpp including lsp, format and debug feature
local _M = {}
_M["plugins.setup.lspconfig"] = function(C)
	table.insert(C.lsp_servers, "clangd")
	C.clients_format_disabled["clangd"] = true
end

_M["plugins.setup.dap"] = function(C)
	C.cpp_adapter = {
		id = "cppdbg",
		type = "executable",
		command = "OpenDebugAD7",
	}
	C.setup_cpp_adapter = function()
		require("dap").adapters.cppdbg = C.cpp_adapter
	end
end

_M["plugins.setup.null-ls"] = function(C)
	table.insert(C.config.sources, require("null-ls").builtins.formatting.clang_format)
end

_M["plugins.setup_config"] = function(C)
	table.insert(C["nvim-treesitter/nvim-treesitter"].setup.config.ensure_installed, "cpp")
	table.insert(C["nvim-treesitter/nvim-treesitter"].setup.config.ensure_installed, "c")
end

require("core").register_override_config(_M)
