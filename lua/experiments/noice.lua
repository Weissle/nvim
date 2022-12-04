local _M = {}

_M["plugins.setup_config"] = function(C)
	C["folke/noice.nvim"] = {
		setup = {
			module = "noice",
			config = {
				cmdline = {
					enabled = false,
				},
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = false, -- position the cmdline and popupmenu together
					long_message_to_split = false, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			},
		},
	}
end

_M["plugins.plugins"] = function(C)
	C["folke/noice.nvim"] = {
		-- disable = true,
		disable = not vim.fn.has("nvim-0.8.0"),
		requires = { "MunifTanjim/nui.nvim" },
		after = { "nui.nvim" },
		config = function()
			require("plugins.setup_manager").setup("folke/noice.nvim")
			vim.cmd([[set shortmess+=cs]])
		end,
	}
end

require("core").register_override_config(_M)
