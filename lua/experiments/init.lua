local core = require("core")
local _M = {}

_M["plugins.plugins"] = function(C)
	C["nvim-treesitter/nvim-treesitter-textobjects"] = {
		after = "nvim-treesitter",
		config = function()
			require("experiments.nvim-treesitter-textobjects").setup()
		end,
	}
end

core.register_override_config(_M)
