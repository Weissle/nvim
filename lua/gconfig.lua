local M = {}

M.lsp_servers = { "sumneko_lua" }

M.treesitter_required = { "lua" }

M = require("core").merge_configs(M, "gconfig")

return M
