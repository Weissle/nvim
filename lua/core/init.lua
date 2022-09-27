local M = {}

local version = vim.version()
M.vim_version = {
	major = version.major,
	minor = version.minor,
	patch = version.patch,
}

M.merge_user_config = function(default_config, config_name)
	local user_config_exist, user_config = pcall(require, "custom")
	if user_config_exist and user_config[config_name] then
		local f = user_config[config_name]
		if type(f) == "function" then
			return f(default_config)
		elseif type(f) == "table" then
			return vim.tbl_deep_extend("force", default_config, f)
		else
			vim.notify("type(require('custom').%s) should be function or table rather than %s", "ERROR", nil)
			return default_config
		end
	end
	return default_config
end

M.keymap_opts = { noremap = true, silent = true }

M.get_keymap_empty_bucket = function()
	local ret = {}
	setmetatable(ret, {
		__index = function(_, d)
			ret[d] = {}
			return ret[d]
		end,
	})
	return ret
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
