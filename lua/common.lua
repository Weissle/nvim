local M = {}

M.get_lsp_server_list = function ()
	return { 'pyright', 'clangd', 'tsserver', 'cmake', 'bashls', 'lemminx', 'sumneko_lua' }
end


M.shallow_copy = function (orig)
    local copy
    if type(orig) ~= 'table' then
		return orig
	else
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
		return copy
	end
end

M.sim_input =  function (key_str)
	local key = vim.api.nvim_replace_termcodes(key_str,true,false,true)
	vim.api.nvim_feedkeys(key,'t',false)
end

M.notify_default = {
	timeout = 3,
}

M.async_notify = function (message, type, opts)
	local async = require("plenary.async")
	local notify = require("notify").async
	if opts == nil then
		opts = M.notify_default
	end
	async.run(function()
		notify(message,type,opts)
	end,nil)
end

M.enter_term_autocmd = function ()
	vim.api.nvim_create_augroup('move-to-term',{clear=true})
	vim.api.nvim_create_autocmd('BufEnter',{
		group = 'move-to-term',
		callback = function ()
			local file_name = vim.api.nvim_buf_get_name(0)
			if string.find(file_name,'^term') then
				vim.cmd('startinsert')
			end
		end
	})
end

return M
