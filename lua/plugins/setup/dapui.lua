local M = {}
local dap, dapui = require("dap"), require("dapui")

M.dap_initialized_callback = function()
	dapui.open({})
end

M.setup = function()
	dapui.setup()
	dap.listeners.after.event_initialized["dapui_config"] = M.dap_initialized_callback
end

M = require("core").merge_configs(M, "plugins.setup.dapui")
return M
