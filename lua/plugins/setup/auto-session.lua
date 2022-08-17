local M = {}

local close_all_floating_wins = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= '' then
			vim.api.nvim_win_close(win, false)
		end
	end
end

local close_all_not_file_things = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)
		if #vim.fn.glob(name) == 0 then
			vim.api.nvim_win_close(win, false)
			vim.api.nvim_buf_delete(buf)
		end
	end
end

local close_nvim_tree = function ()
	vim.cmd('NvimTreeClose')
end

M.setup = function (_)
	local auto_session = require("auto-session")
	vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
	_G.close_all_floating_wins = close_all_floating_wins
	_G.close_nvim_tree = close_nvim_tree
	_G.close_all_not_file_things = close_all_not_file_things
	auto_session.setup {
		log_level = 'error',
		auto_session_suppress_dirs = {'~/'},
		pre_save_cmds = { _G.close_all_floating_wins, _G.close_nvim_tree, _G.close_all_not_file_things },
	}
end

return M
