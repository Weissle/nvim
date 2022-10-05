local M = {}

local version = vim.version()

M.vim_version = string.format("%d.%d.%d", version.major, version.minor, version.patch)

local override_config_list = {}

M.register_override_config = function(cfg)
	assert(type(cfg) == "table")
	table.insert(override_config_list, cfg)
end

M.merge_configs = function(config, config_name)
	for _, cfg in ipairs(override_config_list) do
		local ext, ret = cfg[config_name], nil
		if type(ext) == "function" then
			ret = ext(config)
		elseif type(ext) == "table" then
			ret = vim.tbl_deep_extend("force", config, ext)
		elseif ext ~= nil then
			vim.notify(
				"type(require('custom').%s) should be function or table rather than %s",
				vim.log.levels.ERROR,
				nil
			)
		end
	end
	return ret or config
end

M.keymap_opts = { noremap = true, silent = true }

M.get_keymap_empty_bucket = function()
	if M.vim_version >= "0.8.0" then
		return vim.defaulttable({})
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

M.set_keymap_bucket = function(cfg)
	local opts = M.keymap_opts
	local keymap = vim.keymap.set
	for mode, tbl in pairs(cfg) do
		for ori, dst in pairs(tbl) do
			if type(dst) == "table" then
				keymap(mode, ori, dst[1], dst.opts)
			else
				keymap(mode, ori, dst, opts)
			end
		end
	end
end

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

return M
