local M = {}

M.setup = function(_)
	local groups = require("bufferline.groups")
	require("bufferline").setup({
		options = {
			groups = {
				items = {
					groups.builtin.ungrouped,
					{
						name = "Bash",
						auto_close = false,
						matcher = function(buf)
							return buf.filename == "bash" or buf.filename == "zsh"
						end,
					},
				},
			},
		},
	})
	require("mappings.fl_mappings").bufferline()
end

return M
