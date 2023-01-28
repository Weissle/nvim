return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", lazy = true },
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
		keys = { ":", "/", "i" },
		config = function()
			local M = {}
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local compare = require("cmp").config.compare

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

			local cmp_item_kind = require("cmp.types").lsp.CompletionItemKind

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
				mapping = {
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
				},
				sources = {
					{
						name = "nvim_lsp",
						entry_filter = function(entry, ctx)
							local entry_label_length = #entry["completion_item"]["label"]
							local length_max = M.entry_label_length_max or 80
							if entry_label_length > length_max then
								return false
							end
							local cmp_kind = cmp_item_kind[entry:get_kind()]
							return cmp_kind ~= "Snippet" and cmp_kind ~= "Text"
						end,
						priority = 1,
						max_item_count = 15,
					},
					{ name = "luasnip", priority = 1 },
					{ name = "path", priority = 1 },
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
						priority = 1,
					},
				},
				completion = {
					keyword_length = 2,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						-- compare.exact,
						compare.score,
						compare.offset,
						-- -- compare.scopes,
						compare.recently_used,
						-- compare.locality,
						-- compare.kind,
						-- compare.sort_text,
						-- compare.length,
						-- compare.order,
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

			-- M.remove_redundant_quota = function()
			-- 	cmp.event:on("confirm_done", function()
			-- 		local r, c = unpack(vim.api.nvim_win_get_cursor(0))
			-- 		local line = vim.api.nvim_buf_get_lines(0, r - 1, r, true)[1]
			-- 		local ch1, ch2 = string.sub(line, c, c), string.sub(line, c + 1, c + 1)
			-- 		if ch1 == ch2 and (ch1 == '"' or ch1 == "'") then
			-- 			line = string.sub(line, 0, c - 1) .. string.sub(line, c + 1) .. " "
			-- 			vim.api.nvim_buf_set_lines(0, r - 1, r, true, { line })
			-- 		end
			-- 	end)
			-- end

			for _, v in pairs(M) do
				if (type(v)) == "function" then
					v()
				end
			end
		end,
	},
}
