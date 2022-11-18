require("options.coc.base")
local _M = {}

_M["plugins.plugins.config"] = {
	group = {
		lsp = false,
		cmp = false,
	},
}

_M["plugins.plugins"] = function(C)
	C["neoclide/coc.nvim"] = {
		branch = "release",
		config = function()
			vim.api.nvim_create_autocmd("User", {
				group = "CocGroup",
				pattern = "CocJumpPlaceholder",
				command = "call CocActionAsync('showSignatureHelp')",
				desc = "Update signature help on jump placeholder",
			})
		end,
	}
end

_M["settings.opt"] = function(opt)
	opt.updatetime = 300
	-- opt.signcolumn = "yes"
end

_M["mappings.plugin"] = function(K)
	K["n"]["<leader>la"] = "<Plugin>(coc-codeaction)"
	K["n"]["<leader>lh"] = "<cmd>lua _G.show_docs()<cr>"
	--K["n"]["<leader>ls"] = vim.lsp.buf.signature_help
	K["n"]["<leader>lr"] = "<Plug>(coc-rename)"
	-- K["n"]["<leader>lt"] = "<cmd>Telescope lsp_type_definitions<cr>"
	-- K["n"]["<leader>ld"] = "<cmd>Telescope diagnostics<cr>"
	-- diagnostic
	K["n"]["[d"] = "<Plug>(coc-diagnostic-prev)"
	K["n"]["]d"] = "<Plug>(coc-diagnostic-next)"
	-- K["n"]["<leader>lo"] = vim.diagnostic.open_float

	-- frequently use
	-- K["n"]["gi"] = "<cmd>Telescope lsp_implementations<cr>"
	-- K["n"]["gd"] = "<cmd>Telescope lsp_definitions initial_mode=normal<cr>"
	-- K["n"]["gr"] = "<cmd>Telescope lsp_references initial_mode=normal<cr>"
	-- symbols_outline
	K["n"]["<leader>lS"] = ":<C-u>CocList outline<cr>"
end

require("core").register_override_config(_M)
