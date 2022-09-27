local M = {}

M.create_empty_function = function(ret)
	return function(...)
		return ret
	end
end

return M
