local M = {}
local core = require("core")

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
	return core.merge_user_config(K, "mappings.plugin_builtin.telescope")
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
	return core.merge_user_config(K, "mappings.plugin_builtin.cmp")
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
	return core.merge_user_config(K, "mappings.plugin_builtin.mini_surround")
end

M.bufjump = function()
	local K = {
		forward = "<leader>bi",
		backward = "<leader>bo",
	}
	return core.merge_user_config(K, "mappings.plugin_builtin.bufjump")
end

return M
