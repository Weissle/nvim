local dap = require('dap')
local mason_registry = require("mason-registry")
local get_package_dir = function (name)
	return mason_registry.get_package(name):get_install_path()
end
dap.adapters.python = {
	type = 'executable',
	command = get_package_dir('debugpy') .. '/venv/bin/python',
	args = {'-m', 'debugpy.adapter'}
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = 'OpenDebugAD7',
}

require('dap.ext.vscode').load_launchjs(nil)
