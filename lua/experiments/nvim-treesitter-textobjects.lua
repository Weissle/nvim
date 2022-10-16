local K = {
	select = {
		enable = true,
		keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
		},
	},
	swap = {
		enable = true,
		swap_next = {
			["<leader>sn"] = "@parameter.inner",
		},
		swap_previous = {
			["<leader>sp"] = "@parameter.inner",
		},
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			["]m"] = "@function.outer",
		},
		goto_next_end = {
			["]M"] = "@function.outer",
		},
		goto_previous_start = {
			["[m"] = "@function.outer",
		},
		goto_previous_end = {
			["[M"] = "@function.outer",
		},
	},
}

-- place to mappings.plugin_builtin.nvim-treesitter-textobjects in the future.
require("core").merge_configs(K, "mappings.plugin_builtin.nvim-treesitter-textobjects")

return {
	setup = function()
		require("nvim-treesitter.configs").setup({
			textobjects = K,
		})
	end,
}
