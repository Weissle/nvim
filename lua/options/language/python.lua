-- For language python including lsp, debug feature

local _M = {}

_M["plugins.setup.lspconfig"] = function(C)
	table.insert(C.lsp_servers, "pyright")
end

_M["plugins.setup.dap"] = function(C)
	C.python_adapter = {
		type = "executable",
		command = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python",
		args = { "-m", "debugpy.adapter" },
	}
	C.setup_python_adapter = function()
		require("dap").adapters.python = C.python_adapter
	end
end

_M["plugins.setup_config"] = function(C)
	table.insert(C["nvim-treesitter/nvim-treesitter"].setup.config.ensure_installed, "python")
end

require("core").register_override_config(_M)
