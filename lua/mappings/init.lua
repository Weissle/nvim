local core = require("core")
local M = core.get_keymap_empty_bucket()

-- since <space> is the <leader>
M["n"][" "] = "<NOP>"
M["i"]["jj"] = "<C-[>"
M["i"]["<C-h>"] = "<left>"
M["i"]["<C-l>"] = "<right>"
M["i"]["<C-k>"] = "<up>"
M["i"]["<C-j>"] = "<down>"
M["i"]["<C-a>"] = "<C-o>A"

M["s"]["<BS>"] = "<Space><BS>"

M = core.merge_configs(M, "mappings.init")

core.set_keymap_bucket(M)
