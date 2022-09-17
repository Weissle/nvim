local core = require("core")
local M = core.get_keymap_empty_bucket()

M["n"][" "] = "<NOP>"
M["n"]["<F3>"] = "<cmd>noh<cr>"
M["i"]["jj"] = "<C-[>"
M["i"]["<C-h>"] = "<left>"
M["i"]["<C-l>"] = "<right>"
M["i"]["<C-k>"] = "<up>"
M["i"]["<C-j>"] = "<down>"
M[""]["J"] = "gJ"

--> Quit or Close
M["n"]["<leader>qq"] = "<cmd>wq<cr>"
--> so long due to the bug of terminal mode
M["n"]["<leader>qa"] = "<cmd>wa<cr><bar><cmd>qa<cr>"
M["n"]["<leader>qt"] = "<cmd>q<cr>"
M["n"]["<leader>qw"] = "<cmd>wa<cr>"

M["s"]["<BS>"] = "<Space><BS>"

M["t"]["jj"] = "<C-\\><C-n>"
M["t"]["<C-w>j"] = "<C-\\><C-n><C-w>j"
M["t"]["<C-w>h"] = "<C-\\><C-n><C-w>h"
M["t"]["<C-w>k"] = "<C-\\><C-n><C-w>k"
M["t"]["<C-w>l"] = "<C-\\><C-n><C-w>l"
M["t"]["<C-w><C-j>"] = "<C-\\><C-n><C-w>j"
M["t"]["<C-w><C-h>"] = "<C-\\><C-n><C-w>h"
M["t"]["<C-w><C-k>"] = "<C-\\><C-n><C-w>k"
M["t"]["<C-w><C-l>"] = "<C-\\><C-n><C-w>l"
M["t"]["gt"] = "<C-\\><C-n><cmd>tabn<cr>"
M["t"]["gT"] = "<C-\\><C-n><cmd>tabN<cr>"
M["t"]["<leader>qt"] = "<cmd>q<cr>"
M["t"]["<leader>qq"] = "exit<cr>"

M["n"]["<leader>tt"] = "<cmd>tabnew<cr><bar><cmd>terminal<cr>i"
M["n"]["<leader>tx"] = "<cmd>sp<cr><bar><cmd>terminal<cr>i"
M["n"]["<leader>tv"] = "<cmd>vsp<cr><bar><cmd>terminal<cr>i"

M = core.merge_user_config(M, "mappings.mappings")

core.set_keymap_bucket(M)
