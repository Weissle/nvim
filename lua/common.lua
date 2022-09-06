local M = {}

M.get_lsp_server_list = function()
	return { "pyright", "clangd", "tsserver", "cmake", "bashls", "lemminx", "sumneko_lua", "texlab" }
end

M.autocmd_enter_term = function()
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
end

return M
