local opt = vim.opt
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

vim.g.mapleader = " "

vim.cmd[[autocmd FileType * set formatoptions-=cro]]

vim.defer_fn(function()
	vim.cmd("set clipboard+=unnamedplus")

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

	vim.api.nvim_create_augroup("autosave", { clear = true })
	vim.api.nvim_create_autocmd("BufLeave", {
		group = "autosave",
		callback = function()
			pcall(vim.cmd, "write")
		end,
	})
end, 1000)

