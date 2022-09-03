local M = {}

M.setup = function(_)
	vim.cmd("colorscheme tokyonight")
	vim.cmd("hi Visual guibg=#006699")
	vim.cmd[[highlight VertSplit guibg=bg guifg=#6699FF]]
end

return M

