local M = {}

local override_config_list = {}

M.register_override_config = function(cfg)
	assert(type(cfg) == "table")
	table.insert(override_config_list, cfg)
end

M.merge_configs = function(config, config_name)
	local ret = config
	for _, cfg in ipairs(override_config_list) do
		local ext = cfg[config_name]
		if type(ext) == "function" then
			ret = ext(ret) or ret
		elseif type(ext) == "table" then
			ret = vim.tbl_deep_extend("force", ret, ext)
		elseif ext ~= nil then
			vim.notify(
				"type(require('custom').%s) should be function or table rather than %s",
				vim.log.levels.ERROR,
				nil
			)
		end
	end
	return ret
end

return M
