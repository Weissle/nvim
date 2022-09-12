-- setup when the plugin is loaded.
local M = {}

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

M.lspconfig = function()
	vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<Leader>lh", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<Leader>ls", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.formatting, opts)
	vim.keymap.set("n", "<Leader>lt", vim.lsp.buf.type_definition, opts)
	-- diagnostic
	vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<Leader>do", vim.diagnostic.open_float, opts)
	keymap("n", "<Leader>fd", "<cmd>Telescope diagnostics<cr>", opts)
	-- frequently use
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
end

M.bufferline = function()
	keymap("n", "<leader>bj", "<cmd>BufferLinePick<cr>", opts)
	keymap("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", opts)
	keymap("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", opts)
	keymap("n", "<leader>ql", "<cmd>BufferLineCloseLeft<cr>", opts)
	keymap("n", "<leader>qr", "<cmd>BufferLineCloseRight<cr>", opts)
end

M.bufremove = function()
	keymap("n", "<leader>qb", "<cmd>lua require('mini.bufremove').delete(0,false)<cr>", opts)
	keymap("t", "<leader>qb", "<cmd>lua require('mini.bufremove').delete(0,false)<cr>", opts)
end

M.ufo = function()
	vim.keymap.set("n", "zR", require("ufo").openAllFolds, opts)
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds, opts)
end

M.hop = function()
	for _, mode in ipairs({ "n", "x", "o" }) do
		keymap(
			mode,
			"f",
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
			opts
		)
		keymap(
			mode,
			"F",
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
			opts
		)
		keymap(
			mode,
			"t",
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
			opts
		)
		keymap(
			mode,
			"T",
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
			opts
		)
		keymap(
			"",
			"<leader>he",
			"<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, multi_windows = true })<cr>",
			opts
		)
	end
end

M.telescope = function()
	keymap(
		"n",
		"<Leader>fk",
		'<cmd>lua require("telescope.builtin").keymaps{ modes = {"n","i","c","x","v","o"} }<cr>',
		opts
	)
end

return M
