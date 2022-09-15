local opt = vim.opt
opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.cursorline = true
opt.termguicolors = true
opt.smartcase = true
opt.ignorecase = true
opt.guicursor = "n-v-c-sm:blinkon01,i-ci-ve:ver25-blinkon01,r-cr-o:hor20"
opt.jumpoptions = "stack"
opt.splitright = true
opt.splitbelow = true
opt.incsearch = false
opt.fixeol = false

vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.auto_session_enabled = false

vim.cmd([[autocmd FileType * set formatoptions-=cro]])
vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])

vim.api.nvim_create_user_command("PluginsSetup", function()
	require("plugins.setup.packer").setup({})
	vim.cmd("PackerInstall")
	vim.cmd("PackerSync")
end, {})

vim.defer_fn(function()
	vim.cmd("set clipboard+=unnamedplus")

	require("gfunction").autocmd_enter_term()

	vim.api.nvim_create_augroup("autosave", { clear = true })
	vim.api.nvim_create_autocmd("BufLeave", {
		group = "autosave",
		callback = function()
			pcall(vim.cmd, "write")
		end,
	})
end, 1000)
