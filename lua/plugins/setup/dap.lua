local M = {}
local dap = require("dap")
local mason_registry = require("mason-registry")
local get_package_dir = function(name)
	return mason_registry.get_package(name):get_install_path()
end

M.load_launchjs = function()
	require("dap.ext.vscode").load_launchjs(nil)
end

M.setup_autocmd_reload_launchjson = function()
	vim.api.nvim_create_augroup("dap_reload_launchjson", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "launch.json" },
		group = "dap_reload_launchjson",
		callback = function()
			print(123)
			require("dap").configurations = {}
			require("dap.ext.vscode").load_launchjs(nil)
		end,
	})
end

M.setup_python_adapter = function()
	dap.adapters.python = {
		type = "executable",
		command = get_package_dir("debugpy") .. "/venv/bin/python",
		args = { "-m", "debugpy.adapter" },
	}
end
M.setup_cpp_adapter = function()
	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = "OpenDebugAD7",
	}
end

M.setup = function()
	for k, f in pairs(M) do
		if k ~= "setup" and type(f) == "function" then
			f()
		end
	end
end

M = require("core").merge_configs(M, "plugins.setup.dap")

return M
