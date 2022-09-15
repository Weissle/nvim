local M = {}

M.setup = function(_)
	require("tokyonight").setup({
		on_highlights = function(highlights, colors)
			highlights.VertSplit = {
				fg = "#6699FF",
			}
			highlights.WinSeparator = {
				fg = "#6699FF",
			}
		end,
	})
	vim.cmd("colorscheme " .. require("gconfig").colorscheme)
end

return M
