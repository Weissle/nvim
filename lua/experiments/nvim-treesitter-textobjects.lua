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
	},
}

require("core").merge_configs(K, "mappings.plugin_builtin.nvim-treesitter-textobjects")

return {
	setup = function()
		require("nvim-treesitter.configs").setup({
			textobjects = K,
		})
	end,
}
