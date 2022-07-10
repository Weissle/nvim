local breakpoints = require('dap.breakpoints')
local M = {}
local cp_dir = '/tmp/.nvim_checkpoints'

M.create_father_path = function ()
	os.execute('mkdir -p ' .. cp_dir)
end

local get_bps_path = function ()
	local cp_filename = (vim.fn.getcwd()):gsub('/','_') .. '.json'
	return cp_dir .. '/' .. cp_filename
end

local load_bps = function (path)
	local fp = io.open(path,'r')
	local bps = {}
	if fp ~= nil then
		local load_bps_raw = fp:read('*a')
		bps = vim.fn.json_decode(load_bps_raw)
		fp:close()
	end
	return bps
end

M.store_breakpoints = function (clear)
	local bps_path = get_bps_path()
	local bps = load_bps(bps_path)
	local breakpoints_by_buf = breakpoints.get()
	if (clear) then
		bps = {}
	else
		for buf, buf_bps in pairs(breakpoints_by_buf) do
			bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
		end
	end
	local fp = io.open(bps_path, 'w+')
	if fp == nil then
		require('common').async_notify('Failed to save checkpoints. File: ' .. vim.fn.expand('%'), 'WARN')
		return
	end
	fp:write(vim.fn.json_encode(bps))
	fp:close()
end


M.load_breakpoints = function()
	local bps_path = get_bps_path()
	local bps = load_bps(bps_path)
	breakpoints.clear()
    local loaded_buffers = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local file_name = vim.api.nvim_buf_get_name(buf)
        if (bps[file_name] ~= nil and bps[file_name] ~= {}) then
			loaded_buffers[file_name] = buf
        end
    end
	for path, buf_bps in pairs(bps) do
		if loaded_buffers[path] ~= nil then
			for _, bp in pairs(buf_bps) do
				local line = bp.line
				local opts = {
					condition = bp.condition,
					log_message = bp.logMessage,
					hit_condition = bp.hitCondition
				}
				breakpoints.set(opts, tonumber(loaded_buffers[path]), line)
			end
		end

	end
end

return M
