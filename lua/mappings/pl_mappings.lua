local M = {}

M.telescope = function()
	local action = require("telescope.actions")
	return {
		n = {
			["q"] = action.close,
		},
		i = {
			["<ESC>"] = action.close,
		},
	}
end

M.cmp = function()
	local luasnip = require("luasnip")
	local cmp = require("cmp")
	return {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
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
end

return M
