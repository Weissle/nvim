local M = {}

M.setup = function (_)
	local ext1, dap = pcall(require,"dap")
	local ext2, dapui = pcall(require,"dapui")
	if not ext1 or not ext2 then
		return
	end
	local dap, dapui = require("dap"), require("dapui")
	dapui.setup()
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open{}
	end
	-- HACK: Below is not worked. ?? So change the <leader>dT in mapping.
	dap.listeners.after.event_terminated["dapui_config"] = function()
		dapui.close{}
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close{}
	end
end

return M
