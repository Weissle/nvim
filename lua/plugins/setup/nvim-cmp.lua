local M = {}

M.setup = function(_)
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local kind_icons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	local cmp_source = {
		["nvim_lsp"] = "LSP",
		["luasnip"] = "Snip",
		["cmp_tabnine"] = "Tab",
		["path"] = "Path",
		["buffer"] = "Buf",
		["treesitter"] = "TeS",
		["nvim_lua"] = "NLua",
		["cmdline"] = "Cmd",
		["latex_symbols"] = "Tex",
	}
	local cmp_item_kind = require("cmp.types").lsp.CompletionItemKind
	cmp.setup({
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
				vim_item.menu = cmp_source[entry.source.name]
				return vim_item
			end,
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = require("mappings.pl_mappings").cmp(),
		sources = {
			{
				name = "nvim_lsp",
				entry_filter = function(entry, ctx)
					return cmp_item_kind[entry:get_kind()] ~= "Snippet"
				end,
			},
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "treesitter" },
			{ name = "nvim_lua" },
			{ name = "latex_symbols" },
		},
	})

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "nvim_lua" },
			{ name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=], keyword_length = 3 },
			{ name = "path" },
		}),
	})

	local function remove_redundant_pair()
		local r, c = unpack(vim.api.nvim_win_get_cursor(0))
		local line = vim.api.nvim_buf_get_lines(0, r - 1, r, true)[1]
		local ch1, ch2 = string.sub(line, c, c), string.sub(line, c + 1, c + 1)
		if ch1 == ch2 and (ch1 == '"' or ch1 == "'") then
			line = string.sub(line, 0, c - 1) .. string.sub(line, c + 1) .. " "
			vim.api.nvim_buf_set_lines(0, r - 1, r, true, { line })
		end
	end
	cmp.event:on("confirm_done", remove_redundant_pair)
end

return M
