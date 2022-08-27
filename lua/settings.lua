vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.guicursor = "n-v-c-sm:blinkon01,i-ci-ve:ver25-blinkon01,r-cr-o:hor20"
vim.o.jumpoptions = "stack"
vim.g.mapleader = " "
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.incsearch = false

vim.defer_fn(function()
	vim.cmd("set clipboard+=unnamedplus")
end, 1000)
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
