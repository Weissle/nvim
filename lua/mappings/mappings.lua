local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", " ", "<NOP>", opts)
keymap("n", "<F3>", "<cmd>noh<cr>", opts)
keymap("i", "jj", "<C-[>", opts)
keymap("i", "<C-h>", "<left>", opts)
keymap("i", "<C-l>", "<right>", opts)
keymap("i", "<C-k>", "<up>", opts)
keymap("i", "<C-j>", "<down>", opts)

--> Quic or Close
keymap("n", "<leader>qq", "<cmd>wq<cr>", opts)
--> so long due to the bug of toggleTerm
keymap("n", "<leader>qa", "<cmd>wa<cr><bar><cmd>qa<cr>", opts)
keymap("n", "<leader>qt", "<cmd>q<cr>", opts)
keymap("n", "<leader>qw", "<cmd>wa<cr>", opts)

keymap("t", "jj", "<C-\\><C-n>", opts)
keymap("t", "<C-w>j", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-w>h", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-w>k", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-w>l", "<C-\\><C-n><C-w>l", opts)
keymap("t", "gt", "<C-\\><C-n><cmd>tabn<cr>", opts)
keymap("t", "gT", "<C-\\><C-n><cmd>tabN<cr>", opts)

require("mappings.fl_mappings").nvim_tree()
require("mappings.fl_mappings").todo_comments()
require("mappings.fl_mappings").toggleterm()
