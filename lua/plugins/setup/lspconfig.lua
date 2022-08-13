local M = {}

M.setup = function (_)
	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	end

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = require('common').get_lsp_server_list()
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

	local special_setup = { ['sumneko_lua'] = true }
	for _, lsp in pairs(servers) do
		if special_setup[lsp] == nil then
			require('lspconfig')[lsp].setup {
				capabilities = capabilities,
				on_attach = on_attach,
			}
		end
	end

	require'lspconfig'.sumneko_lua.setup {
		capabilities = capabilities,
		on_attach = on_attach,
		settings= {
			Lua = {
				runtime = {
					version = 'LuaJIT'
				},
				diagnostics = {
					globals = { 'vim' }
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		}
	}
end

return M
