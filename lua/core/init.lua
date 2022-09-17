local M = {}

local version = vim.version()
M.vim_version = {
	major = version.major,
	minor = version.minor,
	patch = version.patch,
}

M.merge_user_config = function(default_config, config_name)
	local _, user_config = pcall(require, "custom")
	user_config = user_config or {}
	local cfg = user_config[config_name] or {}
	return vim.tbl_deep_extend("force", default_config, cfg)
end

M.do_nothing = function(...) end

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

return M
