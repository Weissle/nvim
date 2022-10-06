local M = {}
local core = require("core")

M.enable_unnamedplus = function()
	vim.defer_fn(function()
		vim.cmd([[set clipboard+=unnamedplus]])
	end, 500)
end

M.setup_startinsert_in_terminal = function()
	vim.defer_fn(function()
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

M.setup_auto_format = function()
	vim.api.nvim_create_augroup("autoformat", { clear = true })
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		group = "autoformat",
		callback = function()
			local clients = vim.lsp.buf_get_clients()
			local formatable = false
			for k, v in pairs(clients) do
				formatable = v.resolved_capabilities.document_formatting or formatable
			end
			if formatable == false then
				return
			elseif core.vim_version >= "0.8.0" then
				--HACK: need test
				vim.lsp.format()
			else
				vim.lsp.buf.formatting_sync()
			end
		end,
	})
end

M = require("core").merge_configs(M, "settings.functions")

return M
