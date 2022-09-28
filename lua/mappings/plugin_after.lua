-- setup when the plugin is loaded.
local M = {}
local core = require("core")

M.lspconfig = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>la"] = vim.lsp.buf.code_action
	K["n"]["<leader>lh"] = vim.lsp.buf.hover
	K["n"]["<leader>ls"] = vim.lsp.buf.signature_help
	if vim.g._inc_rename_exists ~= true then
		K["n"]["<leader>lr"] = vim.lsp.buf.rename
	end
	K["n"]["<leader>lf"] = vim.lsp.buf.formatting
	K["n"]["<leader>lt"] = vim.lsp.buf.type_definition
	-- diagnostic
	K["n"]["<leader>dp"] = vim.diagnostic.goto_prev
	K["n"]["<leader>dn"] = vim.diagnostic.goto_next
	K["n"]["<leader>do"] = vim.diagnostic.open_float
	-- frequently use
	K["n"]["gi"] = vim.lsp.buf.implementation
	K["n"]["gD"] = vim.lsp.buf.declaration
	K["n"]["gd"] = vim.lsp.buf.definition
	K = core.merge_configs(K, "mappings.plugin_preset.lspconfig")
	core.set_keymap_bucket(K)
end

M.bufferline = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>bj"] = "<cmd>BufferLinePick<cr>"
	K["n"]["<leader>bn"] = "<cmd>BufferLineCycleNext<cr>"
	K["n"]["<leader>bp"] = "<cmd>BufferLineCyclePrev<cr>"
	K["n"]["<leader>ql"] = "<cmd>BufferLineCloseLeft<cr>"
	K["n"]["<leader>qr"] = "<cmd>BufferLineCloseRight<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.buferline")
	core.set_keymap_bucket(K)
end

M.bufremove = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>qb"] = "<cmd>lua require('mini.bufremove').delete(0)<cr>"
	K["t"]["<leader>qb"] = "<cmd>lua require('mini.bufremove').delete(0)<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.bufremove")
	core.set_keymap_bucket(K)
end

M.ufo = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["zR"] = require("ufo").openAllFolds
	K["n"]["zM"] = require("ufo").closeAllFolds
	K = core.merge_configs(K, "mappings.plugin_preset.ufo")
	core.set_keymap_bucket(K)
end

M.hop = function()
	local K = core.get_keymap_empty_bucket()
	K[""]["<leader>hl"] = "<cmd>HopLineStartMW<cr>"
	K[""]["<leader>hw"] = "<cmd>HopWordMW<cr>"
	K[""]["<leader>hx"] = "<cmd>HopChar2MW <cr>"
	K[""]["<leader>h/"] = "<cmd>HopPatternMW <cr>"
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
	K = core.merge_configs(K, "mappings.plugin_after.hop")
	core.set_keymap_bucket(K)
end

M.telescope = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>fk"] = "<cmd>lua require('telescope.builtin').keymaps{ modes = {'n','i','c','x','v','o'} }<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.telescope")
	core.set_keymap_bucket(K)
end

M.inc_rename = function()
	local K = core.get_keymap_empty_bucket()
	local opts = vim.deepcopy(core.keymap_opts)
	opts.expr = true
	K["n"]["<leader>lr"] = {
		function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end,
		opts = opts,
	}
	K = core.merge_configs(K, "mappings.plugin_preset.inc_rename")
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
	K["n"]["<leader>fH"] = "<cmd>Telescope harpoon marks<cr>"
	K["n"]["<leader>ha"] = "<cmd>lua require('harpoon.mark').add_file()<cr>"
	K["n"]["<leader>hC"] = "<cmd>lua require('harpoon.mark').clear_all()<cr>"
	K["n"]["<leader>hn"] = "<cmd>lua require('harpoon.ui').nav_next()<cr>"
	K["n"]["<leader>hp"] = "<cmd>lua require('harpoon.ui').nav_prev()<cr>"
	K = core.merge_configs(K, "mappings.plugin_preset.spectre")
	core.set_keymap_bucket(K)
end

return M
