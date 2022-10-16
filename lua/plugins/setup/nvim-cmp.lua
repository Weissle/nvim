local M = {}
local cmp = require("cmp")
local luasnip = require("luasnip")

M.kind_icons = {
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

M.cmp_source = {
	["nvim_lsp"] = "LSP",
	["luasnip"] = "Snip",
	["path"] = "Path",
	["buffer"] = "Buf",
	["cmdline"] = "Cmd",
}

-- Moving it out of function makes it faster?
local cmp_item_kind = require("cmp.types").lsp.CompletionItemKind
M.nvim_lsp_entry_filter = function(entry, ctx)
	local cmp_kind = cmp_item_kind[entry:get_kind()]
	return cmp_kind ~= "Snippet" and cmp_kind ~= "Text"
end

M.insert_config = {
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s %s", M.kind_icons[vim_item.kind], vim_item.kind)
			vim_item.menu = M.cmp_source[entry.source.name]
			return vim_item
		end,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = require("mappings.plugin_builtin").cmp(),
	sources = {
		{
			name = "nvim_lsp",
			entry_filter = M.nvim_lsp_entry_filter,
		},
		{ name = "luasnip" },
		{ name = "path" },
		{
			name = "buffer",
			option = {
				-- PERF: It may slows down you paste and delete motion.
				get_bufnrs = function()
					local ret = {}
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_line_count(buf) <= 5000 then
							table.insert(ret, buf)
						end
					end
					return ret
				end,
			},
		},
	},
}

M.setup_insert_mode = function()
	cmp.setup(M.insert_config)
end

M.search_config = {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
}

M.setup_search_mode = function()
	cmp.setup.cmdline("/", M.search_config)
end

M.command_config = {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=], keyword_length = 3 },
		{ name = "path" },
	}),
}

M.setup_command_mode = function()
	cmp.setup.cmdline(":", M.search_config)
end

M.remove_redundant_quota = function()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_buf_get_lines(0, r - 1, r, true)[1]
	local ch1, ch2 = string.sub(line, c, c), string.sub(line, c + 1, c + 1)
	if ch1 == ch2 and (ch1 == '"' or ch1 == "'") then
		line = string.sub(line, 0, c - 1) .. string.sub(line, c + 1) .. " "
		vim.api.nvim_buf_set_lines(0, r - 1, r, true, { line })
	end
end

M.auto_snip_jump = function(entry)
	local cmp_kind = cmp_item_kind[entry.entry:get_kind()]
	-- Don't jump when the completion item is snippet or now is the select mode.
	local dont_jump = cmp_kind == "Snippet" or vim.api.nvim_get_mode().mode == "s"
	if not dont_jump and luasnip.jumpable(1) then
		luasnip.jump(1)
	end
end

M.setup_confirm_done_callback = function()
	cmp.event:on("confirm_done", M.remove_redundant_quota)
	cmp.event:on("confirm_done", M.auto_snip_jump)
end

M.setup = function()
	M.setup_insert_mode()
	M.setup_search_mode()
	M.setup_command_mode()
	M.setup_confirm_done_callback()
end

require("core").merge_configs(M, "plugins.setup.nvim-cmp")

return M
