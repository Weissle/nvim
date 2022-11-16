local M = {}
local core = require("core")

M.enable_unnamedplus = function()
	vim.defer_fn(function()
		vim.cmd([[set clipboard+=unnamedplus]])
	end, 500)
end

M.disable_auto_comment = [[autocmd FileType * set formatoptions-=cro]]

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
			for _, v in pairs(clients) do
				if core.vim_version >= "0.8.0" then
					formatable = v.server_capabilities.documentFormattingProvider or formatable
				else
					formatable = v.resolved_capabilities.document_formatting or formatable
				end
			end
			if formatable == false then
				return
			elseif core.vim_version >= "0.8.0" then
				vim.lsp.buf.format()
			else
				vim.lsp.buf.formatting_sync()
			end
		end,
	})
end

M.restore_cursor = function()
	vim.cmd(
		[[autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
	)
end

M = require("core").merge_configs(M, "settings.functions")

return M
