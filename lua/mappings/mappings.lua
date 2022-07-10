local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap


keymap('n',' ','<NOP>',opts)
keymap('n','<F3>','<cmd>noh<cr>',opts)
keymap('i','jj','<C-[>',opts)
keymap('i','<C-h>','<left>',opts)
keymap('i','<C-l>','<right>',opts)
keymap('i','<C-k>','<up>',opts)
keymap('i','<C-j>','<down>',opts)
keymap('n','<A-[>','<cmd>keepjumps normal {<cr>',opts)
keymap('n','<A-]>','<cmd>keepjumps normal }<cr>',opts)

--> nvim-tree.lua
keymap('n','<C-n>',':NvimTreeToggle<CR>',opts)
keymap('n','<C-b>',':NvimTreeFindFileToggle<CR>',opts)

--> telescope.nvim
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
keymap('n','<Leader>fn','<cmd>Telescope notify<cr>',opts)
keymap('n','<Leader>fu','<cmd>Telescope git_status<cr>',opts)

--> hop.nvim
for _, mode in ipairs({'n','x','o'}) do
	keymap(mode, 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", opts)
	keymap(mode, 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", opts)
	keymap(mode, 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", opts)
	keymap(mode, 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", opts)
end

-- keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = 1})<cr>", opts)
-- keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1})<cr>", opts)
keymap('', '<leader>hl', "<cmd>HopLineStartMW<cr>", opts)
keymap('', '<leader>hw', "<cmd>HopWordMW<cr>", opts)
keymap('', '<leader>he', "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, multi_windows = true })<cr>", opts)
keymap('', '<leader>hx', "<cmd>HopChar2MW <cr>", opts)
keymap('', '<leader>h/', "<cmd>HopPatternMW <cr>", opts)


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

--> BufferLine
keymap('n','<leader>b','<cmd>BufferLinePick<cr>',opts)

--> Dap
keymap("n", "<leader>da", "<cmd>lua require'dap'.toggle_breakpoint(); require('plugins.dap-utils').store_breakpoints()<cr>", opts)
keymap("n", "<leader>dA", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.run_to_cursor()<cr>", opts)
keymap("n", "<leader>ds", "<cmd>lua require'dap'.pause()<cr>", opts)
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
keymap("n", "K", "<cmd>lua require'dapui'.eval()<cr>", opts)
keymap("t", "jj", "<C-\\><C-n>", opts)

