require("options.language.lua")

local _M = {}

_M["plugins.plugins"] = function(C)
	C["folke/lua-dev.nvim"] = {
		module = "neodev",
	}
	-- impatient may change the startup order. See its readme.
	C["lewis6991/impatient.nvim"] = nil
end

_M["plugins.setup_config"] = function(C)
	C["folke/lua-dev.nvim"] = {
		setup = {
			module = "neodev",
			config = {},
		},
	}

	C["neovim/nvim-lspconfig"].preset.setup_neodev = function()
		require("plugins.setup_manager").setup("folke/lua-dev.nvim")
	end
end

require("core").register_override_config(_M)
