local M = {}
local dap, dapui = require("dap"), require("dapui")

M.dap_initialized_callback = function()
	dapui.open({})
end

M.dap_terminated_callback = function()
	dapui.close({})
end

M.dap_exited_callback = function()
	dapui.close({})
end

M.setup = function()
	dapui.setup()
	dap.listeners.after.event_initialized["dapui_config"] = M.dap_initialized_callback
	dap.listeners.before.event_terminated["dapui_config"] = M.dap_terminated_callback
	dap.listeners.before.event_exited["dapui_config"] = M.dap_exited_callback
end

M = require("core").merge_configs(M, "plugins.setup.dapui")
return M
