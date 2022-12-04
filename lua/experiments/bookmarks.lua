local _M = {}

local bookmarks_builtin_keymap = function()
	return {
		toggle = "<leader>bz",
		add = "<leader>ba",
		order = "<leader>bS",
		delete_on_virt = "<leader>bA",
		show_desc = "<leader>bs",
	}
end

_M["plugins.setup_config"] = function(C)
	C["crusj/bookmarks.nvim"] = {
		setup = {
			module = "bookmarks",
			config = {
				keymap = bookmarks_builtin_keymap(),
			},
		},
	}
end

_M["plugins.plugins"] = function(C)
	C["crusj/bookmarks.nvim"] = {
		branch = "main",
		config = function()
			require("plugins.setup_manager").setup("crusj/bookmarks.nvim")
		end,
	}
end

require("core").register_override_config(_M)
