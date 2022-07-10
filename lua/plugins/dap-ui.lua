local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open(nil)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close(nil)
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close(nil)
end
