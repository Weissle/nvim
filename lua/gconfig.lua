local M = {}

M.lsp_server_list = { "pyright", "clangd", "tsserver", "cmake", "bashls", "lemminx", "sumneko_lua", "texlab" }

M.colorscheme_plugin = "tokyonight"
M.colorscheme = "tokyonight"

M = require("core").merge_user_config(M, "gconfig")

return M
