return {
	{
		"neoclide/coc.nvim",
		enabled = false,
		branch = "release",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			vim.opt.updatetime = 100
			vim.opt.signcolumn = "yes"
			vim.g["coc_global_extensions"] = {
				"coc-json",
				"coc-clangd",
				"coc-cmake",
				"coc-lists",
				"coc-snippets",
				"coc-pyright",
				"coc-tabnine",
				"coc-xml",
				"coc-yaml",
				"coc-sumneko-lua",
			}
			local keyset = vim.keymap.set

			-- Autocomplete
			function _G.check_back_space()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
			end

			-- Use Tab for trigger completion with characters ahead and navigate
			-- NOTE: There's always a completion item selected by default, you may want to enable
			-- no select by setting `"suggest.noselect": true` in your configuration file
			-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
			-- other plugins before putting this into your config
			local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
			-- keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
			keyset(
				"i",
				"<TAB>",
				"coc#pum#visible() ? coc#pum#confirm() :  v:lua.check_back_space() ? '<TAB>' : coc#refresh()",
				opts
			)

			-- coc#expandableOrJumpable() ? '\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\\<CR>' :
			keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
			keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
			keyset("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true })
			keyset("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true })

			-- GoTo code navigation
			keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
			keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
			keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
			keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

			-- Use K to show documentation in preview window
			function _G.show_docs()
				local cw = vim.fn.expand("<cword>")
				if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
					vim.api.nvim_command("h " .. cw)
				elseif vim.api.nvim_eval("coc#rpc#ready()") then
					vim.fn.CocActionAsync("doHover")
				else
					vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
				end
			end
			keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

			-- Symbol renaming
			keyset("n", "<leader>lr", "<Plug>(coc-rename)", { silent = true })

			vim.api.nvim_create_augroup("CocGroup", { clear = true })
			-- Update signature help on jump placeholder
			vim.api.nvim_create_autocmd("User", {
				group = "CocGroup",
				pattern = "CocJumpPlaceholder",
				command = "call CocActionAsync('showSignatureHelp')",
				desc = "Update signature help on jump placeholder",
			})

			-- Apply codeAction to the selected region
			-- Example: `<leader>aap` for current paragraph
			opts = { silent = true, nowait = true }

			-- Map function and class text objects
			-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
			keyset({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)", opts)
			keyset({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)", opts)
			keyset({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)", opts)
			keyset({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)", opts)
		end,
	},
}
