local M = {}

-- UPDATE CAPABILITIES COPY FROM CMP_NVIM_LSP
local if_nil = function(val, default)
	if val == nil then
		return default
	end
	return val
end

local update_capabilities = function(capabilities, override)
	override = override or {}

	local completionItem = capabilities.textDocument.completion.completionItem

	completionItem.snippetSupport = if_nil(override.snippetSupport, true)
	completionItem.preselectSupport = if_nil(override.preselectSupport, true)
	completionItem.insertReplaceSupport = if_nil(override.insertReplaceSupport, true)
	completionItem.labelDetailsSupport = if_nil(override.labelDetailsSupport, true)
	completionItem.deprecatedSupport = if_nil(override.deprecatedSupport, true)
	completionItem.commitCharactersSupport = if_nil(override.commitCharactersSupport, true)
	completionItem.tagSupport = if_nil(override.tagSupport, { valueSet = { 1 } })
	completionItem.resolveSupport = if_nil(override.resolveSupport, {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	})

	return capabilities
end
-- END

M.setup = function(_)
	local lspconfig = require("lspconfig")

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = require("common").get_lsp_server_list()

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	update_capabilities(capabilities)

	local special_setup = {
		sumneko_lua = true,
		clangd = true,
	}

	for _, lsp in pairs(servers) do
		if special_setup[lsp] == nil then
			lspconfig[lsp].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end
	end

	lspconfig.sumneko_lua.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
				completion = {
					autoRequire = false,
					keywordSnippet = "Disable",
				},
			},
		},
	})
	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = { "clangd", "--header-insertion=never" },
	})
end

return M
