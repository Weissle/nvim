local M = {}
local core = require("core")

M.telescope = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>ff"] = "<cmd>Telescope find_files<cr>"

	if vim.g._telescope_live_grep_args_exists ~= true then
		K["n"]["<leader>fg"] = "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>"
	else
		K["n"]["<leader>fg"] = "<cmd>Telescope live_grep<cr>"
	end

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
	K["n"]["<leader>fm"] = "<cmd>Telescope marks<cr>"
	K["n"]["<leader>fk"] = "<cmd>lua require('telescope.builtin').keymaps{ modes = {'n','i','c','x','v','o'} }<cr>"
	K["n"]["gr"] = "<cmd>Telescope lsp_references<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.telescope")
	core.set_keymap_bucket(K)
end

M.todo_comments = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>fT"] = "<cmd>TodoTelescope <cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.todo_comments")
	core.set_keymap_bucket(K)
end

M.notify = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>fn"] = "<cmd>Telescope notify<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.notify")
	core.set_keymap_bucket(K)
end

M.session_lens = function()
	if vim.g.auto_session_enabled ~= false then
		local K = core.get_keymap_empty_bucket()
		K["n"]["<leader>fs"] = "<cmd>Telescope session-lens search_session<cr>"
		K = core.merge_configs(K, "mappings.plugin_preset.session_lens")
		core.set_keymap_bucket(K)
	end
end

M.neogen = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>of"] = "<cmd>Neogen func<cr>"
	K["n"]["<leader>oc"] = "<cmd>Neogen class<cr>"
	K["n"]["<leader>ot"] = "<cmd>Neogen type<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.neogen")
	core.set_keymap_bucket(K)
end

M.symbols_outline = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>lS"] = "<cmd>SymbolsOutline<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.symbols_outline")
	core.set_keymap_bucket(K)
end

M.smart_split = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>mr"] = "<cmd>SmartResizeMode<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.smart_split")
	core.set_keymap_bucket(K)
end

M.nvim_tree = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<C-n>"] = "<cmd>NvimTreeToggle<cr>"
	K["n"]["<leader>nn"] = "<cmd>NvimTreeToggle<cr>"
	K["n"]["<leader>nm"] = "<cmd>NvimTreeFindFile<cr>"
	K["n"]["<leader>nf"] = "<cmd>NvimTreeFocus<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.nvim_tree")
	core.set_keymap_bucket(K)
end

M.spectre = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>so"] = "<cmd>lua require('spectre').open()<cr>"
	K["n"]["<leader>sw"] = "<cmd>lua require('spectre').open_visual({select_word=true})<cr>"
	K["n"]["<leader>sf"] = "<cmd>lua require('spectre').open_file_search()<cr>"
	K["x"]["<leader>sf"] = "<cmd>lua require('spectre').open_visual()<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.spectre")
	core.set_keymap_bucket(K)
end

M.harpoon = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>ha"] = "<cmd>lua require('harpoon.mark').add_file()<cr>"
	K["n"]["<leader>hC"] = "<cmd>lua require('harpoon.mark').clear_all()<cr>"
	K["n"]["<leader>hn"] = "<cmd>lua require('harpoon.ui').nav_next()<cr>"
	K["n"]["<leader>hp"] = "<cmd>lua require('harpoon.ui').nav_prev()<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.harpoon")
	core.set_keymap_bucket(K)
end

M.hop = function()
	local K = core.get_keymap_empty_bucket()
	K[""]["<leader>hl"] = "<cmd>HopLineStartMW<cr>"
	K[""]["<leader>hw"] = "<cmd>HopWordMW<cr>"
	for _, mode in ipairs({ "n", "x", "o" }) do
		K[mode]["<leader>hf"] =
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
		K[mode]["<leader>hF"] =
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
		K[mode]["<leader>ht"] =
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
		K[mode]["<leader>hT"] =
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
		K[mode]["<leader>he"] =
			"<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, multi_windows = true })<cr>"
	end
	K = core.merge_configs(K, "mappings.plugin_preset.hop")
	core.set_keymap_bucket(K)
end

return M
