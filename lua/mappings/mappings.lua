local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", " ", "<NOP>", opts)
keymap("n", "<F3>", "<cmd>noh<cr>", opts)
keymap("i", "jj", "<C-[>", opts)
keymap("i", "<C-h>", "<left>", opts)
keymap("i", "<C-l>", "<right>", opts)
keymap("i", "<C-k>", "<up>", opts)
keymap("i", "<C-j>", "<down>", opts)

--> Quit or Close
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
keymap("t", "<C-w><C-j>", "<C-\\><C-n><C-w>j", opts)
keymap("t", "<C-w><C-h>", "<C-\\><C-n><C-w>h", opts)
keymap("t", "<C-w><C-k>", "<C-\\><C-n><C-w>k", opts)
keymap("t", "<C-w><C-l>", "<C-\\><C-n><C-w>l", opts)
keymap("t", "gt", "<C-\\><C-n><cmd>tabn<cr>", opts)
keymap("t", "gT", "<C-\\><C-n><cmd>tabN<cr>", opts)
keymap("t", "<leader>qt", "<cmd>q<cr>", opts)
keymap("t", "<leader>qq", "exit<cr>", opts)

keymap("n", "<leader>tt", "<cmd>tabnew<cr><bar><cmd>terminal<cr>i", opts)
keymap("n", "<leader>tx", "<cmd>sp<cr><bar><cmd>terminal<cr>i", opts)
keymap("n", "<leader>tv", "<cmd>vsp<cr><bar><cmd>terminal<cr>i", opts)

keymap("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<Leader>fc", "<cmd>Telescope commands<cr>", opts)
keymap("n", "<Leader>ft", "<cmd>Telescope <cr>", opts)
keymap("n", "<Leader>fa", "<cmd>Telescope find_files no_ignore=true<cr>", opts)
keymap("n", "<Leader>f*", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<Leader>fo", "<cmd>Telescope oldfiles<cr>", opts)
keymap(
	"n",
	"<Leader>fk",
	'<cmd>lua require("telescope.builtin").keymaps{ modes = {"n","i","c","x","v","o"} }<cr>',
	opts
)
keymap("n", "<Leader>fG", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<Leader>fr", "<cmd>Telescope resume<cr>", opts)
keymap("n", "<Leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
if vim.g.auto_session_enabled ~= false then
	keymap("n", "<Leader>fs", "<cmd>Telescope session-lens search_session<cr>", opts)
end
keymap("n", "<Leader>fn", "<cmd>Telescope notify<cr>", opts)
keymap("n", "<Leader>fT", "<cmd>TodoTelescope <cr>", opts)

keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<C-b>", ":NvimTreeFindFileToggle<CR>", opts)

keymap("n", "<leader>mw", "<cmd>SmartResizeMode<cr>", opts)

keymap("", "<leader>hl", "<cmd>HopLineStartMW<cr>", opts)
keymap("", "<leader>hw", "<cmd>HopWordMW<cr>", opts)

keymap("", "<leader>hx", "<cmd>HopChar2MW <cr>", opts)
keymap("", "<leader>h/", "<cmd>HopPatternMW <cr>", opts)

keymap("n", "<Leader>of", "<cmd>Neogen func<CR>", opts)
keymap("n", "<Leader>oc", "<cmd>Neogen class<CR>", opts)
keymap("n", "<Leader>ot", "<cmd>Neogen type<CR>", opts)
