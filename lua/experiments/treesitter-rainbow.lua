local _M = {}

_M["plugins.setup_config"] = function(C)
	C["nvim-treesitter/nvim-treesitter"].setup.config.rainbow = {
		enable = true,
		extened_mode = true,
		max_file_lines = 5000,
	}
end

_M["plugins.plugins"] = function(C)
	C["p00f/nvim-ts-rainbow"] = {
		after = "nvim-treesitter",
		config = function()
			require("plugins.setup_manager").setup("p00f/nvim-ts-rainbow")
		end,
	}
end

require("core").register_override_config(_M)
