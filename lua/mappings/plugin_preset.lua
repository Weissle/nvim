local M = {}
local core = require("core")
M.telescope = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>ff"] = "<cmd>Telescope find_files<cr>"
	K["n"]["<leader>fg"] = "<cmd>Telescope live_grep<cr>"
	K["n"]["<leader>fb"] = "<cmd>Telescope buffers<cr>"
	K["n"]["<leader>fh"] = "<cmd>Telescope help_tags<cr>"
	K["n"]["<leader>fc"] = "<cmd>Telescope commands<cr>"
	K["n"]["<leader>ft"] = "<cmd>Telescope <cr>"
	K["n"]["<leader>fa"] = "<cmd>Telescope find_files no_ignore=true<cr>"
	K["n"]["<leader>f*"] = "<cmd>Telescope grep_string<cr>"
	K["n"]["<leader>fo"] = "<cmd>Telescope oldfiles<cr>"
	K["n"]["<leader>fG"] = "<cmd>Telescope git_status<cr>"
	K["n"]["<leader>fr"] = "<cmd>Telescope resume<cr>"
	K["n"]["<leader>f/"] = "<cmd>Telescope current_buffer_fuzzy_find<cr>"
	K["n"]["<leader>fd"] = "<cmd>Telescope diagnostics<cr>"
	K["n"]["gr"] = "<cmd>Telescope lsp_references<cr>"
	K = core.merge_user_config(K, "mappings.plugin_preset.telescope")
	core.set_keymap_bucket(K)
end

M.todo_comments = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>fT"] = "<cmd>TodoTelescope <cr>"
	K = core.merge_user_config(K, "mappings.plugin_preset.todo_comments")
	core.set_keymap_bucket(K)
end

M.notify = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>fn"] = "<cmd>Telescope notify<cr>"
	K = core.merge_user_config(K, "mappings.plugin_preset.notify")
	core.set_keymap_bucket(K)
end

M.session_lens = function()
	if vim.g.auto_session_enabled ~= false then
		local K = core.get_keymap_empty_bucket()
		K["n"]["<leader>fs"] = "<cmd>Telescope session-lens search_session<cr>"
		K = core.merge_user_config(K, "mappings.plugin_preset.session_lens")
		core.set_keymap_bucket(K)
	end
end

M.neogen = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>of"] = "<cmd>Neogen func<cr>"
	K["n"]["<leader>oc"] = "<cmd>Neogen class<cr>"
	K["n"]["<leader>ot"] = "<cmd>Neogen type<cr>"
	K = core.merge_user_config(K, "mappings.plugin_preset.neogen")
	core.set_keymap_bucket(K)
end

M.symbols_outline = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>lS"] = "<cmd>SymbolsOutline<cr>"
	K = core.merge_user_config(K, "mappings.plugin_preset.symbols_outline")
	core.set_keymap_bucket(K)
end

M.smart_split = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>mw"] = "<cmd>SmartResizeMode<cr>"
	K = core.merge_user_config(K, "mappings.plugin_preset.smart_split")
	core.set_keymap_bucket(K)
end

M.nvim_tree = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<C-n>"] = ":NvimTreeToggle<cr>"
	K["n"]["<C-b>"] = ":NvimTreeFindFileToggle<cr>"
	K = core.merge_user_config(K, "mappings.plugin_preset.nvim_tree")
	core.set_keymap_bucket(K)
end

return M
