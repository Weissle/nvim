local M = {}

M.lsp_server_list = { "pyright", "clangd", "tsserver", "cmake", "bashls", "lemminx", "sumneko_lua", "texlab" }

M.colorscheme_plugin = "tokyonight"
M.colorscheme = "tokyonight"
local version = vim.version()

M.vim_version = {
	major = version.major,
	minor = version.minor,
	patch = version.patch
}

return M
