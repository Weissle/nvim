local M = {}
local version = vim.version()

M.vim_version = string.format("%d.%d.%d", version.major, version.minor, version.patch)

M.create_default_table = function()
	if M.vim_version >= "0.8.0" then
		return vim.defaulttable()
	else
		local ret = {}
		setmetatable(ret, {
			__index = function(_, d)
				ret[d] = {}
				return ret[d]
			end,
		})
		return ret
	end
end

M.create_empty_function = function(ret)
	return function(...)
		return ret
	end
end

--- Execute everything executable.
---@param cmd string|function|table
M.call = function(cmd)
	if type(cmd) == "string" then
		vim.cmd(cmd)
	elseif type(cmd) == "function" then
		cmd()
	elseif type(cmd) == "table" then
		for _, v in pairs(cmd) do
			M.call(v)
		end
	end
end

--- return a table contains one member `setup` which call all functions in T.
---@param T table
---@return table
M.setup_helper = function(T)
	return {
		setup = function()
			for _, v in pairs(T) do
				if type(v) == "function" then
					v()
				end
			end
		end,
	}
end

return M
