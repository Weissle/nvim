vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.smartcase = true
vim.o.ignorecase = true

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])



vim.g.mapleader = ' '


vim.defer_fn(function ()
	vim.o.clipboard = 'unnamedplus'
end,100)
