local core = require("core")

local B = core.get_keymap_empty_bucket()
-- since <space> is the <leader>
B["n"][" "] = "<NOP>"
B["i"]["jj"] = "<C-[>"
B["i"]["<C-h>"] = "<left>"
B["i"]["<C-l>"] = "<right>"
B["i"]["<C-k>"] = "<up>"
B["i"]["<C-j>"] = "<down>"
B["i"]["<C-a>"] = "<C-o>A"
B["s"]["<BS>"] = "<Space><BS>"
B = core.merge_configs(B, "mappings.base")
core.set_keymap_bucket(B)

local P = core.get_keymap_empty_bucket()

-- lspconfig
P["n"]["<leader>la"] = vim.lsp.buf.code_action
P["n"]["<leader>lh"] = vim.lsp.buf.hover
P["n"]["<leader>ls"] = vim.lsp.buf.signature_help
P["n"]["<leader>lr"] = vim.lsp.buf.rename
P["n"]["<leader>lf"] = function()
	if core.vim_version < "0.8.0" then
		vim.lsp.buf.formatting()
	else
		vim.lsp.buf.format()
	end
end
P["n"]["<leader>lt"] = "<cmd>Telescope lsp_type_definitions<cr>"
P["n"]["<leader>ld"] = "<cmd>Telescope diagnostics<cr>"
-- diagnostic
P["n"]["[d"] = vim.diagnostic.goto_prev
P["n"]["]d"] = vim.diagnostic.goto_next
P["n"]["<leader>lo"] = vim.diagnostic.open_float
-- frequently use
P["n"]["gi"] = "<cmd>Telescope lsp_implementations<cr>"
P["n"]["gD"] = vim.lsp.buf.declaration
P["n"]["gd"] = "<cmd>Telescope lsp_definitions initial_mode=normal<cr>"
P["n"]["gr"] = "<cmd>Telescope lsp_references initial_mode=normal<cr>"

-- bufferline
P["n"]["<leader>bj"] = "<cmd>BufferLinePick<cr>"
P["n"]["<leader>bn"] = "<cmd>BufferLineCycleNext<cr>"
P["n"]["<leader>bp"] = "<cmd>BufferLineCyclePrev<cr>"
P["n"]["<leader>ql"] = "<cmd>BufferLineCloseLeft<cr><C-L>"
P["n"]["<leader>qr"] = "<cmd>BufferLineCloseRight<cr><C-L>"
P["n"]["<leader>qo"] = "<cmd>BufferLineCloseRight<cr><bar><cmd>BufferLineCloseLeft<cr><C-L>"

-- bufremove
P["n"]["<leader>qb"] = "<cmd>lua require('mini.bufremove').delete(0)<cr>"
P["t"]["<leader>qb"] = "<cmd>lua require('mini.bufremove').delete(0)<cr>"

-- ufo
P["n"]["zR"] = "<cmd>lua require('ufo').openAllFolds()<cr>"
P["n"]["zM"] = "<cmd>lua require('ufo').closeAllFolds()<cr>"

-- telescope
P["n"]["<leader>ff"] = "<cmd>Telescope find_files<cr>"
P["n"]["<leader>fg"] = "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>"
P["n"]["<leader>fb"] = "<cmd>Telescope buffers<cr>"
P["n"]["<leader>fh"] = "<cmd>Telescope help_tags<cr>"
P["n"]["<leader>fc"] = "<cmd>Telescope commands<cr>"
P["n"]["<leader>ft"] = "<cmd>Telescope <cr>"
P["n"]["<leader>fa"] = "<cmd>Telescope find_files no_ignore=true hidden=true<cr>"
P["n"]["<leader>f*"] = "<cmd>Telescope grep_string<cr>"
P["n"]["<leader>fo"] = "<cmd>Telescope oldfiles<cr>"
P["n"]["<leader>fG"] = "<cmd>Telescope git_status<cr>"
P["n"]["<leader>fr"] = "<cmd>Telescope resume<cr>"
P["n"]["<leader>f/"] = "<cmd>Telescope current_buffer_fuzzy_find<cr>"
P["n"]["<leader>fm"] = "<cmd>Telescope marks<cr>"
P["n"]["<leader>fk"] = "<cmd>lua require('telescope.builtin').keymaps{ modes = {'n','i','c','x','v','o'}}<cr>"

-- dap
P["n"]["<leader>dt"] = "<cmd>lua require('dap').run_to_cursor()<cr>"
P["n"]["<leader>dp"] = "<cmd>lua require('dap').pause()<cr>"
P["n"]["<leader>dT"] = "<cmd>lua require('dap').terminate(); require('dapui').close()<cr>"
P["n"]["<F4>"] = "<cmd>lua require'dap'.terminate()<cr>"
P["n"]["<F5>"] = "<cmd>lua require'dap'.continue()<cr>"
P["n"]["<F6>"] = "<cmd>lua require'dap'.step_into()<cr>"
P["n"]["<F7>"] = "<cmd>lua require'dap'.step_over()<cr>"
P["n"]["<F8>"] = "<cmd>lua require'dap'.step_out()<cr>"
P["n"]["<F9>"] = "<cmd>lua require'dap'.run_last()<cr>"
P["n"]["<leader>ba"] = "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>"
P["n"]["<leader>bc"] = "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>"
P["n"]["<leader>bC"] = "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>"

-- dapui
P["n"]["<leader>du"] = "<cmd>lua require('dapui').toggle()<cr>"
P[{ "n", "x" }]["<leader>de"] = "<cmd>lua require('dapui').eval()<cr>"

-- telescope_dap
P["n"]["<leader>dc"] = "<cmd>Telescope dap configurations<cr>"
P["n"]["<leader>dC"] = "<cmd>Telescope dap commands<cr>"
P["n"]["<leader>dv"] = "<cmd>Telescope dap variables<cr>"
P["n"]["<leader>db"] = "<cmd>Telescope dap list_breakpoints<cr>"
P["n"]["<leader>df"] = "<cmd>Telescope dap frames<cr>"

-- yanky
P[{ "n", "x" }]["y"] = "<Plug>(YankyYank)"
P[{ "n", "x" }]["p"] = "<Plug>(YankyPutAfter)"
P[{ "n", "x" }]["P"] = "<Plug>(YankyPutBefore)"
P[{ "n", "x" }]["gp"] = "<Plug>(YankyGPutAfter)"
P[{ "n", "x" }]["gP"] = "<Plug>(YankyGPutBefore)"
P["n"]["<c-n>"] = "<Plug>(YankyCycleForward)"
P["n"]["<c-p>"] = "<Plug>(YankyCycleBackward)"
P["n"]["<leader>fy"] = "<cmd>Telescope yank_history<cr>"

-- notify
P["n"]["<leader>fn"] = "<cmd>Telescope notify<cr>"
P["n"]["<leader>nd"] = "<cmd>lua vim.notify.dismiss()<cr>"

-- todo_comments
P["n"]["<leader>fT"] = "<cmd>TodoTelescope <cr>"

-- session_lens
if vim.g.auto_session_enabled ~= false then
	P["n"]["<leader>fs"] = "<cmd>Telescope session-lens search_session<cr>"
end

-- neogen
P["n"]["<leader>of"] = "<cmd>Neogen func<cr>"
P["n"]["<leader>oc"] = "<cmd>Neogen class<cr>"
P["n"]["<leader>ot"] = "<cmd>Neogen type<cr>"

-- symbols_outline
P["n"]["<leader>lS"] = "<cmd>SymbolsOutline<cr>"

-- smart_split
P["n"]["<leader>mr"] = "<cmd>SmartResizeMode<cr>"

-- nvim_tree
P["n"]["<leader>nn"] = "<cmd>NvimTreeToggle<cr>"
P["n"]["<leader>nm"] = "<cmd>NvimTreeFindFile<cr>"
P["n"]["<leader>nf"] = "<cmd>NvimTreeFocus<cr>"

-- spectre
P["n"]["<leader>so"] = "<cmd>lua require('spectre').open()<cr>"
P["x"]["<leader>so"] = "<esc><cmd>lua require('spectre').open_visual()<cr>"
P["n"]["<leader>sl"] = "<cmd>lua require('spectre').open_file_search()<cr>"
P["n"]["<leader>sw"] = "<cmd>lua require('spectre').open_visual({select_word=true})<cr>"

local hop_mode = { "n", "x", "o" }
P[hop_mode]["<leader>hl"] = "<cmd>HopLineStartMW<cr>"
P[hop_mode]["<leader>hw"] = "<cmd>HopWordMW<cr>"
P[hop_mode]["f"] =
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
P[hop_mode]["F"] =
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
P[hop_mode]["t"] =
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
P[hop_mode]["T"] =
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
P[hop_mode]["<leader>he"] =
	"<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, multi_windows = true })<cr>"

P = core.merge_configs(P, "mappings.plugin")
core.set_keymap_bucket(P)
