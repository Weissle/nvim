local M = {}

local close_all_floating_wins = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, true)
		end
	end
end

local close_symbols_outline = function()
	pcall(vim.cmd, "SymbolsOutlineClose")
end

M.setup = function(_)
	local auto_session = require("auto-session")
	-- NOTE: folds options is exclusive. Due to ufo is not loaded at startup.
	vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
	_G.close_all_floating_wins = close_all_floating_wins
	_G.close_symbols_outline = close_symbols_outline
	auto_session.setup({
		log_level = "error",
		auto_session_suppress_dirs = { "~/" },
		pre_save_cmds = { "NvimTreeClose", _G.close_all_floating_wins, _G.close_symbols_outline },
	})
end

return M
