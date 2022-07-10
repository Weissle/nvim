vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.guicursor = 'n-v-c-sm:blinkon01,i-ci-ve:ver25-blinkon01,r-cr-o:hor20'
vim.o.jumpoptions = 'stack'
vim.o.hidden = true
vim.g.mapleader = ' '

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

vim.api.nvim_create_augroup('dap_launchjson',{clear=true})
vim.api.nvim_create_autocmd('BufWritePost',{
	pattern = {'launch.json'},
	group = 'dap_launchjson',
	callback = function()
		require('dap').configurations={}
		require('dap.ext.vscode').load_launchjs(nil)
	end
})

local dap_utils = require('plugins.dap-utils')
dap_utils.create_father_path()
vim.api.nvim_create_autocmd({"BufRead"},{ callback = dap_utils.load_breakpoints })

vim.defer_fn(function ()
	vim.o.clipboard = 'unnamedplus'
end,200)
