local M = {}

M.setup = function (_)
	telescope = require('telescope')
	telescope.setup {
		extensions = {
			fzf = {
				fuzzy = true,                    -- false will only do exact matching
				override_generic_sorter = true,  -- override the generic sorter
				override_file_sorter = true,     -- override the file sorter
				case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			}
		},
		defaults = {
			mappings = require('mappings.pl_mappings').telescope()
		}
	}

	local notify_ext, _ = pcall(require,"notify")
	if notify_ext then
		telescope.load_extension("notify")
	end

end

return M
