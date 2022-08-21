-- steup when the plugin is loaded.
local M = {}

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

M.hop = function()
	for _, mode in ipairs({'n','x','o'}) do
		keymap(mode, 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opts)
		keymap(mode, 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opts)
		keymap(mode, 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", opts)
		keymap(mode, 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", opts)
	end
	keymap('', '<leader>hl', "<cmd>HopLineStartMW<cr>", opts)
	keymap('', '<leader>hw', "<cmd>HopWordMW<cr>", opts)
	keymap('', '<leader>he', "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, multi_windows = true })<cr>", opts)
	keymap('', '<leader>hx', "<cmd>HopChar2MW <cr>", opts)
	keymap('', '<leader>h/', "<cmd>HopPatternMW <cr>", opts)

end

M.nvim_tree = function()
	keymap('n','<C-n>',':NvimTreeToggle<CR>',opts)
	keymap('n','<C-b>',':NvimTreeFindFileToggle<CR>',opts)
end

M.telescope = function()
	keymap('n','<Leader>ff','<cmd>Telescope find_files<cr>',opts)
	keymap('n','<Leader>fg','<cmd>Telescope live_grep<cr>',opts)
	keymap('n','<Leader>fb','<cmd>Telescope buffers<cr>',opts)
	keymap('n','<Leader>fh','<cmd>Telescope help_tags<cr>',opts)
	keymap('n','<Leader>fc','<cmd>Telescope commands<cr>',opts)
	keymap('n','<Leader>ft','<cmd>Telescope <cr>',opts)
	keymap('n','<Leader>fa','<cmd>lua require("telescope.builtin").find_files({no_ignore=true}) <cr>',opts)
	keymap('n','<Leader>f*','<cmd>Telescope grep_string<cr>',opts)
	keymap('n','<Leader>fo','<cmd>Telescope oldfiles<cr>',opts)
	keymap('n','<Leader>fk','<cmd>lua require("telescope.builtin").keymaps{ modes = {"n","i","c","x","v","o"} }<cr>',opts)
	keymap('n','<Leader>fG','<cmd>Telescope git_status<cr>',opts)
	keymap('n','<Leader>fr','<cmd>lua require("telescope.builtin").resume()<cr>',opts)
	keymap('n','<Leader>f/','<cmd>Telescope current_buffer_fuzzy_find<cr>',opts)
end

M.session_lens = function()
	keymap('n','<Leader>fs','<cmd>Telescope session-lens search_session<cr>',opts)
end

M.notify = function()
	keymap('n','<Leader>fn','<cmd>Telescope notify<cr>',opts)
end

M.lspconfig = function()
	vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<Leader>ls', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.formatting, opts)
	vim.keymap.set('n', '<Leader>lt', vim.lsp.buf.type_definition, opts)
	-- diagnostic
	vim.keymap.set('n', '<Leader>dp', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<Leader>do', vim.diagnostic.open_float, opts)
	keymap('n', '<Leader>dl', '<cmd>Telescope diagnostics<cr>', opts)
	-- frequently use
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	keymap('n','gr','<cmd>Telescope lsp_references<cr><Esc>',opts)
end

M.bufferline = function()
	keymap('n','<leader>bj','<cmd>BufferLinePick<cr>',opts)
	keymap('n','<leader>bn','<cmd>BufferLineCycleNext<cr>',opts)
	keymap('n','<leader>bp','<cmd>BufferLineCyclePrev<cr>',opts)
	keymap('n','<leader>ql','<cmd>BufferLineCloseLeft<cr>',opts)
	keymap('n','<leader>qr','<cmd>BufferLineCloseRight<cr>',opts)

end

M.dap = function()

	keymap("n", "<leader>da", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", opts)
	keymap("n", "<leader>dA", "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>", opts)
	keymap("n", "<leader>dt", "<cmd>lua require'dap'.run_to_cursor()<cr>", opts)
	keymap("n", "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", opts)
	keymap("n", "<leader>dT", "<cmd>lua require('dap').terminate(); require('dapui').close()<cr>", opts)
	keymap("n", "<leader>dc", "<cmd>Telescope dap configurations<cr>", opts)
	keymap("n", "<leader>dC", "<cmd>Telescope dap commands<cr>", opts)
	keymap("n", "<leader>dv", "<cmd>Telescope dap variables<cr>", opts)
	keymap("n", "<leader>db", "<cmd>Telescope dap list_breakpoints<cr>", opts)
	keymap("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>", opts)
	keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
	keymap("n", "<F6>", "<cmd>lua require'dap'.step_over()<cr>", opts)
	keymap("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", opts)
	keymap("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", opts)
	keymap("n", "<F9>", "<cmd>lua require'dap'.run_last()<cr>", opts)
end

M.dapui = function()
	keymap("n", "<leader>dk", "<cmd>lua require'dapui'.eval()<cr>", opts)

end

M.toggleterm = function()
	keymap("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", opts)
	keymap("n", "<leader>tx", "<cmd>ToggleTerm direction=horizontal<cr>", opts)
	keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", opts)
	keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", opts)
end

M.neogen = function()
	keymap("n", "<Leader>of", "<cmd>Neogen func<CR>", opts)
	keymap("n", "<Leader>oc", "<cmd>Neogen class<CR>", opts)
	keymap("n", "<Leader>ot", "<cmd>Neogen type<CR>", opts)

end

M.smart_split = function()
	keymap('n', '<leader>mw', "<cmd>lua require('smart-splits').start_resize_mode()<cr>", opts)
end

M.todo_comments = function()
	keymap('n','<Leader>fT','<cmd>TodoTelescope <cr>',opts)
end
return M
