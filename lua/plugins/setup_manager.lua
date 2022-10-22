-- The plugins' whose setup is simple will be placed to setup_config.lua
-- The plugins' whose setup is complex will be placed to setup/
local _M = {}
local core = require("core")
local setup_config = require("plugins.setup_config")

_M.setup = function(name)
	local cfg = setup_config[name]
	if cfg.preset then
		core.call(cfg.preset)
	end
	if cfg.setup then
		require(cfg.setup.module).setup(cfg.setup.config)
	end
	if cfg.after then
		core.call(cfg.after)
	end
end

return _M
