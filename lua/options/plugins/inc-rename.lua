local _M = {}

_M["plugins.plugins"] = function(M)
	M["smjonas/inc-rename.nvim"] = {
		disable = require("core").vim_version < "0.8.0",
		after = { "nvim-lspconfig" },
		config = function()
			local config = {}
			if pcall(require, "dressing") then
				config.input_buffer_type = "dressing"
			end
			require("core").merge_configs("inc-rename.config")
			require("inc_rename").setup(config)
		end,
	}
end

_M["mappings.plugin"] = function(P)
	P["n"]["<leader>lr"] = {
		function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end,
		opts = {
			expr = true,
			silent = true,
		},
	}
end

require("core").register_override_config(_M)
