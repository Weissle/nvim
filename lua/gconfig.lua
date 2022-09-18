local M = {}

M.lsp_server_list = { "pyright", "clangd", "tsserver", "cmake", "bashls", "lemminx", "sumneko_lua", "texlab" }

M.colorscheme_plugin = "tokyonight"
M.colorscheme = "tokyonight"

M.lazy_event_enter_file = { "BufRead", "BufNewFile" }
M.lazy_event_start_insert = { "InsertEnter" }

M = require("core").merge_user_config(M, "gconfig")

return M
