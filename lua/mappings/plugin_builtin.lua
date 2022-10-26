-- Plugins' keymap which are set by themselves.
local M = {}
local core = require("core")

-- For Comment.nvim, it will use `gc` and `gb` as prefix. Since we use its default, you can check its README.md in the github.

M.telescope = function()
	local action = require("telescope.actions")
	local K = {
		n = {
			["q"] = action.close,
		},
		i = {
			["<ESC>"] = action.close,
		},
	}
	return core.merge_configs(K, "mappings.plugin_builtin.telescope")
end

M.cmp = function()
	local luasnip = require("luasnip")
	local cmp = require("cmp")
	local K = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-\\>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s" }),
	}
	return core.merge_configs(K, "mappings.plugin_builtin.cmp")
end

M.mini_surround = function()
	local K = {
		add = "<leader>as",
		delete = "ds",
		find = "",
		find_left = "",
		highlight = "",
		replace = "cs",
		update_n_lines = "",
	}
	return core.merge_configs(K, "mappings.plugin_builtin.mini_surround")
end

M.treesitter_textobjects = function()
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
	return require("core").merge_configs({ textobjects = K }, "mappings.plugin_builtin.nvim-treesitter-textobjects")
end

return M
