local M = {}

M.config = {
	options = {
		groups = {
			items = {
				require("bufferline.groups").builtin.ungrouped,
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
}

M.setup = function()
	require("bufferline").setup(M.config)
end

M = require("core").merge_configs(M, "plugins.setup.bufferline")

return M
