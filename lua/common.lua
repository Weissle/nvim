local M = {}

M.sim_input =  function (key_str)
	local key = vim.api.nvim_replace_termcodes(key_str,true,false,true)
	vim.api.nvim_feedkeys(key,'t',false)
end

return M
