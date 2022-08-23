local M = {}

local setup_autocmd_reload_launchjson = function()
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "launch.json" },
		group = "dap_launchjson",
		callback = function()
			require("dap").configurations = {}
			require("dap.ext.vscode").load_launchjs(nil)
		end,
	})
end

M.setup = function(_)
	local dap = require("dap")
	local mason_registry = require("mason-registry")
	vim.api.nvim_create_augroup("dap_launchjson", { clear = true })

	local get_package_dir = function(name)
		return mason_registry.get_package(name):get_install_path()
	end

	dap.adapters.python = {
		type = "executable",
		command = get_package_dir("debugpy") .. "/venv/bin/python",
		args = { "-m", "debugpy.adapter" },
	}

	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = "OpenDebugAD7",
	}

	require("dap.ext.vscode").load_launchjs(nil)
	setup_autocmd_reload_launchjson()
end

return M
