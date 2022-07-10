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
	local bps_path,bps = get_bps_path(),{}
	if clear == nil or clear == false then
		bps = load_bps(bps_path)
		local current_buf_file_name = vim.api.nvim_buf_get_name(0)
		local current_buf_id = vim.api.nvim_get_current_buf()
		local current_buf_breakpoints = breakpoints.get()[current_buf_id]
		bps[current_buf_file_name] = current_buf_breakpoints
	end
	local fp = io.open(bps_path, 'w+')
	if fp == nil then
		require('common').async_notify('Failed to save checkpoints. File: ' .. vim.fn.expand('%'), 'WARN')
		return
	else
		fp:write(vim.fn.json_encode(bps))
		fp:close()
	end
end

local cnt =0

M.load_breakpoints = function()
	cnt = cnt + 1
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
