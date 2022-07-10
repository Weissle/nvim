local M = {}

M.first_install_packer = function ()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		return fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	else
		return nil
	end
end

M.packer_init_config = {
	profile = {
		enable = true,
		threshold = 1,
	},
}

M.packer_config = {
	display = {
		open_fn = function()
			return require('packer.util').float({border='single'})
		end
	}
}

M.tokyonight = function ()
	vim.cmd('colorscheme tokyonight')
	vim.cmd('hi Visual guibg=#006699')
end

M.lualine = function()
	require('lualine').setup {
		options = {
			theme = 'tokyonight',
			disabled_filetypes = { 'dapui_console', 'dap-repl', 'dapui_breakpoints', 'dapui_stacks', 'dapui_scopes', 'dapui_watches' },
		},
	}
end

M.lsp_signature = function ()
	require "lsp_signature".setup {
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded"
		}
	}
end

function _G.close_all_floating_wins()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= '' then
			vim.api.nvim_win_close(win, false)
		end
	end
end

M.auto_session = function ()
	require('auto-session').setup {
		log_level = 'info',
		auto_session_suppress_dirs = {'~/'},
		pre_save_cmds = { _G.close_all_floating_wins }
	}
end

return M
