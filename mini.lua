vim.cmd([[
set nocompatible
set runtimepath^=~/.local/share/nvim/lazy/coc.nvim
filetype plugin indent on
syntax on
set hidden
]])

-- install lazy.nvim (A plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        "neoclide/coc.nvim",
        branch = "release",
    },
    {
        "rmagatti/auto-session",
        name = "auto-session",
        config = true
    }
}
require("lazy").setup(plugins)
