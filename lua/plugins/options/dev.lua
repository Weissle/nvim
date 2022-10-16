require("plugins.options.language.lua")

local _M = {}

_M["plugins.plugins"] = function(C)
	C["folke/lua-dev.nvim"] = {
		module = "neodev",
	}
	-- impatient may change the startup order. See its readme.
	C["lewis6991/impatient.nvim"] = nil
end

_M["plugins.setup.lspconfig"] = function(C)
	local original_setup = C.setup
	C.setup = function()
		require("neodev").setup({})
		original_setup()
	end
end

require("core").register_override_config(_M)
