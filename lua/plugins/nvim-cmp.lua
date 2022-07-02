local luasnip = require 'luasnip'
local cmp = require 'cmp'

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
  TypeParameter = ""
}

local cmp_source = {
	['nvim_lsp'] = 'LSP',
	['luasnip'] = 'Snip',
	['cmp_tabnine'] = 'Tab',
	['path'] = 'Path',
	['buffer'] = 'Buf',
	['treesitter'] = 'TeS',
	['nvim_lua'] = 'NLua',
	['cmdline'] = 'Cmd',
}

cmp.setup {
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
			vim_item.menu = (cmp_source)[entry.source.name]
			return vim_item
		end
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
			vim.cmd('startinsert')
		end,
	},
	mapping = require('mappings.pl_mappings').cmp(),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'cmp_tabnine' },
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'treesitter' },
		{ name = 'nvim_lua' }
	})
}

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'cmdline' },
		{ name = 'nvim_lua' }
	})
})

