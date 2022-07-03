local M = {}

M.telescope = function ()
	local action = require("telescope.actions")
	return {
		n = {
			['q'] = action.close
		},
		i = {
			['<ESC>'] = action.close
		}
	}
end

M.cmp = function ()
	local luasnip = require 'luasnip'
	local cmp = require 'cmp'
	return {
		['<Tab>'] = cmp.mapping(cmp.mapping.confirm {
			select = true,
		},{'i','s','c'}),
		['<C-n>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, {"i","s"}),
		['<C-p>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {"i","s"}),
		['<C-j>'] = cmp.mapping(function (fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				if cmp.visible() then
					cmp.close()
				end
				fallback()
			end
		end, {'i', 's'}),
		['<C-k>'] = cmp.mapping(function (fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				if cmp.visible() then
					cmp.close()
				end
				fallback()
			end
		end, {'i', 's'}),
	}
end

return M
