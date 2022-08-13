local M = {}

local set_enter_term_begin_insert = function()
	vim.api.nvim_create_augroup('move-to-term', { clear = true })
	vim.api.nvim_create_autocmd('BufEnter', {
		group = 'move-to-term',
		callback = function()
			local file_name = vim.api.nvim_buf_get_name(0)
			if string.find(file_name, '^term') then
				vim.cmd('startinsert')
			end
		end
	})
end

M.setup = function(_)
	require("toggleterm").setup()
	set_enter_term_begin_insert()
end

return M
