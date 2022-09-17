local M = {}

M.create_setup_plugins_command = function()
	vim.api.nvim_create_user_command("PluginsSetup", function()
		require("plugins.setup.packer").setup({})
		vim.cmd("PackerInstall")
		vim.cmd("PackerSync")
	end, {})
end

M.enable_unnamedplus = function()
	vim.defer_fn(function ()
		vim.cmd([[set clipboard+=unnamedplus]])	
	end, 500)
end

M.setup_startinsert_in_terminal = function()
	vim.defer_fn(function ()
		vim.api.nvim_create_augroup("move-to-term", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			group = "move-to-term",
			callback = function()
				local file_name = vim.api.nvim_buf_get_name(0)
				if string.find(file_name, "^term") then
					vim.cmd("startinsert")
				end
			end,
		})
	end, 500)
end

M.disable_auto_comment = function()
	vim.cmd([[autocmd FileType * set formatoptions-=cro]])
end

M.disable_number_in_terminal = function()
	vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])
end

M.setup_autosave = function()
	vim.api.nvim_create_augroup("autosave", { clear = true })
	vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
		group = "autosave",
		callback = function()
			pcall(vim.cmd, "write")
		end,
	})
end

M = require("core").merge_user_config(M, "settings.functions")

return M
