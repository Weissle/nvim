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
	K = core.merge_configs(K, "mappings.plugin_after.lspconfig")
	core.set_keymap_bucket(K)
end

M.bufferline = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>bj"] = "<cmd>BufferLinePick<cr>"
	K["n"]["<leader>bn"] = "<cmd>BufferLineCycleNext<cr>"
	K["n"]["<leader>bp"] = "<cmd>BufferLineCyclePrev<cr>"
	K["n"]["<leader>ql"] = "<cmd>BufferLineCloseLeft<cr>"
	K["n"]["<leader>qr"] = "<cmd>BufferLineCloseRight<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.bufferline")
	core.set_keymap_bucket(K)
end

-- called at file `plugins.setup.mini.lua`
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
	K = core.merge_configs(K, "mappings.plugin_after.ufo")
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
	K = core.merge_configs(K, "mappings.plugin_after.inc_rename")
	core.set_keymap_bucket(K)
end

M.harpoon = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>fl"] = "<cmd>Telescope harpoon marks<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.harpoon")
	core.set_keymap_bucket(K)
end

return M
