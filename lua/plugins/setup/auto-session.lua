local M = {}

_G.close_all_floating_wins = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, true)
		end
	end
end

_G.close_symbols_outline = function()
	pcall(vim.cmd, "SymbolsOutlineClose")
end

M.config = {
	log_level = "error",
	auto_session_suppress_dirs = { "~/" },
	pre_save_cmds = { "NvimTreeClose", _G.close_all_floating_wins, _G.close_symbols_outline },
}

M.setup = function()
	-- NOTE: folds options is exclusive. Due to ufo is not loaded at startup.
	vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
	require("auto-session").setup(M.config)
end

M = require("core").merge_user_config(M, "plugins.setup.auto-session")
return M
