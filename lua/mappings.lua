local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap


keymap('n',' ','<NOP>',opts)
keymap('n','<F3>','<cmd>noh<cr>',opts)
keymap('n','<C-k>','<C-o>k',opts)
keymap('i','jj','<C-[>',opts)
keymap('i','<C-h>','<left>',opts)
keymap('i','<C-l>','<right>',opts)
keymap('i','<C-j>','<C-o>j',opts)
keymap('i','<C-k>','<C-o>k',opts)

--> nvim-tree.lua
keymap('n','<C-n>',':NvimTreeToggle<CR>',opts)
keymap('n','<C-m>',':NvimTreeFindFileToggle<CR>',opts)

--> telescope.nvim
keymap('n','<Leader>ff','<cmd>Telescope find_files<cr>',opts)
keymap('n','<Leader>fg','<cmd>Telescope live_grep<cr>',opts)
keymap('n','<Leader>fb','<cmd>Telescope buffers<cr>',opts)
keymap('n','<Leader>fh','<cmd>Telescope help_tags<cr>',opts)
keymap('n','<Leader>fc','<cmd>Telescope commands<cr>',opts)
keymap('n','<Leader>ft','<cmd>Telescope <cr>',opts)

--> hop.nvim
keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opts)
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opts)
keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", opts)
keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", opts)
keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opts)
keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opts)
keymap('n', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", opts)
keymap('v', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", opts)
keymap('o', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", opts)
keymap('n', '<leader>l', "<cmd>HopLineStart<cr>", opts)
keymap('n', '<leader>w', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", opts)
keymap('n', '<leader>b', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", opts)

--> Comment.nvim
--
--
--> AsyncRun
keymap('n', '<F5>', ":AsyncTask file-run<cr>", opts)
keymap('n', '<F6>', ":AsyncTask file-build<cr>", opts)


--> LSP Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<Leader>q', '<cmd>Telescope diagnostic', opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<Leader>wl', function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
keymap('n','<Leader>gr','<cmd>Telescope lsp_references<cr><Esc>',opts)
-- vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, opts)
