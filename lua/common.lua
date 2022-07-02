local async = require("plenary.async")
local notify = require("notify").async

local M = {}

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
	if opts == nil then
		opts = M.notify_default
	end
	async.run(function()
		notify(message,type,opts)
	end,nil)
end

return M
