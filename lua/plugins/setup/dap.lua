local M = {}
local dap = require("dap")

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
			require("dap").configurations = {}
			require("dap.ext.vscode").load_launchjs(nil)
		end,
	})
end

M = require("core").merge_configs(M, "plugins.setup.dap")

return require("core").setup_helper(M)
