local _M = {}

if not vim.fn.has("nvim-0.8.0") then
	return
end

_M["plugins.setup.null-ls"] = function(C)
	local null_cfg = C.config
	local origin_on_attach = null_cfg.on_attach
	null_cfg.on_attach = function(client, bufnr)
		local lsp_format_modifications = require("lsp-format-modifications")
		origin_on_attach(client, bufnr)
		lsp_format_modifications.attach(client, bufnr, { format_on_save = false })
	end
	return C
end

_M["plugins.plugins"] = function(C)
	C["joechrisellis/lsp-format-modifications.nvim"] = {}
end

_M["mappings.plugin"] = function(K)
	K["n"]["<leader>lF"] = K["n"]["<leader>lf"]
	K["n"]["<leader>lf"] = "<cmd>FormatModifications<cr>"
	return K
end

_M["settings.functions"] = function(M)
	M.setup_auto_format = nil
end

require("core").register_override_config(_M)
