local M = {}
local dap = require("dap")
local mason_registry = require("mason-registry")
local get_package_dir = function(name)
	return mason_registry.get_package(name):get_install_path()
end

M.dap_breakpoint_highlight = {
	DapBreakpoint = { ctermbg = 0, fg = "#993939" },
	DapLogPoint = { ctermbg = 0, fg = "#61afef" },
	DapStopped = { ctermbg = 0, fg = "#98c379" },
}

M.setup_breakpoint_highlight = function()
	for k, v in pairs(M.dap_breakpoint_highlight) do
		vim.api.nvim_set_hl(0, k, v)
	end
end

M.dap_breakpoint_style = {
	DapBreakpoint = { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" },
	DapBreakpointCondition = {
		text = "ﳁ",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "",
	},
	DapBreakpointRejected = {
		text = "",
		texthl = "DapBreakpoint",
		linehl = "",
		numhl = "",
	},
	DapLogPoint = { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" },
	DapStopped = { text = "", texthl = "DapStopped", linehl = "", numhl = "" },
}

M.setup_breakpoint_style = function()
	for k, v in pairs(M.dap_breakpoint_style) do
		vim.fn.sign_define(k, v)
	end
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

M.python_adapter = {
	type = "executable",
	command = get_package_dir("debugpy") .. "/venv/bin/python",
	args = { "-m", "debugpy.adapter" },
}

M.setup_python_adapter = function()
	dap.adapters.python = M.python_adapter
end

M.cpp_adapter = {
	id = "cppdbg",
	type = "executable",
	command = "OpenDebugAD7",
}

M.setup_cpp_adapter = function()
	dap.adapters.cppdbg = M.cpp_adapter
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
