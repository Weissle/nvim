-- called if the corresponding plugin is loaded.
local M = {}
local core = require("core")

M.lspconfig = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>la"] = vim.lsp.buf.code_action
	K["n"]["<leader>lh"] = vim.lsp.buf.hover
	K["n"]["<leader>ls"] = vim.lsp.buf.signature_help
	if vim.g._inc_rename_exists == true then
		local opts = vim.deepcopy(core.keymap_opts)
		opts.expr = true
		K["n"]["<leader>lr"] = {
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			opts = opts,
		}
	else
		K["n"]["<leader>lr"] = vim.lsp.buf.rename
	end
	K["n"]["<leader>lf"] = vim.lsp.buf.formatting
	K["n"]["<leader>lt"] = vim.lsp.buf.type_definition
	-- diagnostic
	K["n"]["[d"] = vim.diagnostic.goto_prev
	K["n"]["]d"] = vim.diagnostic.goto_next
	K["n"]["<leader>lo"] = vim.diagnostic.open_float
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
	K["n"]["<leader>ql"] = "<cmd>BufferLineCloseLeft<cr><C-L>"
	K["n"]["<leader>qr"] = "<cmd>BufferLineCloseRight<cr><C-L>"
	K["n"]["<leader>qo"] = "<cmd>BufferLineCloseRight<cr><bar><cmd>BufferLineCloseLeft<cr><C-L>"
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

M.telescope = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>ff"] = "<cmd>Telescope find_files<cr>"

	K["n"]["<leader>fg"] = "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>"
	-- K["n"]["<leader>fg"] = "<cmd>Telescope live_grep<cr>"

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
	K["n"]["<leader>fk"] = "<cmd>lua require('telescope.builtin').keymaps{ modes = {'n','i','c','x','v','o'}}<cr>"
	K["n"]["gr"] = "<cmd>Telescope lsp_references initial_mode=normal<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.telescope")
	core.set_keymap_bucket(K)
end

M.dap = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>dt"] = require("dap").run_to_cursor
	K["n"]["<leader>dp"] = require("dap").pause
	-- K["n"]["<leader>dT"] = "<cmd>lua require('dap').terminate(); require('dapui').close()<cr>"
	K["n"]["<F4>"] = "<cmd>lua require'dap'.terminate()<cr>"
	K["n"]["<F5>"] = "<cmd>lua require'dap'.continue()<cr>"
	K["n"]["<F6>"] = "<cmd>lua require'dap'.step_over()<cr>"
	K["n"]["<F7>"] = "<cmd>lua require'dap'.step_into()<cr>"
	K["n"]["<F8>"] = "<cmd>lua require'dap'.step_out()<cr>"
	K["n"]["<F9>"] = "<cmd>lua require'dap'.run_last()<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.dap")
	core.set_keymap_bucket(K)
end

M.persistent_breakpoints = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>da"] = require("persistent-breakpoints.api").toggle_breakpoint
	K["n"]["<leader>dA"] = require("persistent-breakpoints.api").set_conditional_breakpoint
	K["n"]["<leader>dR"] = require("persistent-breakpoints.api").clear_all_breakpoints
	K = core.merge_configs(K, "mappings.plugin_after.persistent_breakpoints")
	core.set_keymap_bucket(K)
end

M.dapui = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>du"] = require("dapui").toggle
	K[{ "n", "x" }]["<leader>de"] = require("dapui").eval
	K = core.merge_configs(K, "mappings.plugin_after.dapui")
	core.set_keymap_bucket(K)
end

M.telescope_dap = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>dc"] = "<cmd>Telescope dap configurations<cr>"
	K["n"]["<leader>dC"] = "<cmd>Telescope dap commands<cr>"
	K["n"]["<leader>dv"] = "<cmd>Telescope dap variables<cr>"
	K["n"]["<leader>db"] = "<cmd>Telescope dap list_breakpoints<cr>"
	K["n"]["<leader>df"] = "<cmd>Telescope dap frame<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.telescope_dap")
	core.set_keymap_bucket(K)
end

M.yanky = function()
	local K = core.get_keymap_empty_bucket()
	K[{ "n", "x" }]["y"] = "<Plug>(YankyYank)"
	K[{ "n", "x" }]["p"] = "<Plug>(YankyPutAfter)"
	K[{ "n", "x" }]["P"] = "<Plug>(YankyPutBefore)"
	K[{ "n", "x" }]["gp"] = "<Plug>(YankyGPutAfter)"
	K[{ "n", "x" }]["gP"] = "<Plug>(YankyGPutBefore)"
	K["n"]["<c-n>"] = "<Plug>(YankyCycleForward)"
	K["n"]["<c-p>"] = "<Plug>(YankyCycleBackward)"
	K["n"]["<leader>fy"] = "<cmd>Telescope yank_history<cr>"
	K = core.merge_configs(K, "mappings.plugin_after.yanky")
	core.set_keymap_bucket(K)
end

M.notify = function()
	local K = core.get_keymap_empty_bucket()
	K["n"]["<leader>fn"] = "<cmd>Telescope notify<cr>"
	K["n"]["<leader>nd"] = vim.notify.dismiss
	K = core.merge_configs(K, "mappings.plugin_after.notify")
	core.set_keymap_bucket(K)
end

return M
