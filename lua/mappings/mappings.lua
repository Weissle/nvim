local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap


keymap('n',' ','<NOP>',opts)
keymap('n','<F3>','<cmd>noh<cr>',opts)
keymap('n','<C-k>','<C-o>k',opts)
keymap('i','jj','<C-[>',opts)
keymap('i','<C-h>','<left>',opts)
keymap('i','<C-l>','<right>',opts)
-- keymap('i','<C-j>','<C-o>j',opts)
-- keymap('i','<C-k>','<C-o>k',opts)

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
keymap('n','<Leader>fa','<cmd>lua require("telescope.builtin").find_files(no_ignore=true}) <cr>',opts)
keymap('n','<Leader>f*','<cmd>Telescope grep_string<cr>',opts)
keymap('n','<Leader>fo','<cmd>Telescope oldfiles<cr>',opts)
keymap('n','<Leader>fk','<cmd>Telescope keymaps<cr>',opts)

--> hop.nvim
--
keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opts)
keymap('s', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opts)
keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", opts)
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opts)
keymap('s', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opts)
keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", opts)
keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", opts)
keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", opts)
keymap('', '<leader>hl', "<cmd>HopLineStart<cr>", opts)
keymap('', '<leader>hw', "<cmd>lua require'hop'.hint_words()<cr>", opts)
keymap('', '<leader>he', "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", opts)
keymap('', '<leader>hx', "<cmd>HopChar2<cr>", opts)
keymap('', '<leader>hs', "<cmd>HopPattern<cr>", opts)

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
keymap('n', '<Leader>q', '<cmd>Telescope diagnostics<cr>', opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
keymap('n','gr','<cmd>Telescope lsp_references<cr><Esc>',opts)
