local M = {}

M.get_lsp_server_list = function ()
	return { 'pyright', 'clangd', 'tsserver', 'cmake', 'bashls', 'lemminx', 'sumneko_lua' }
end

return M
