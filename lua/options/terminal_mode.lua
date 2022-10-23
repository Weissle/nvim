-- Simple wrap for the neovim terminal feature.
local _M = {}

_M["settings.functions"] = function(C)
	local setup_startinsert_in_terminal = function()
		vim.api.nvim_create_augroup("move-to-term", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			group = "move-to-term",
			callback = function()
				local file_name = vim.api.nvim_buf_get_name(0)
				if string.find(file_name, "^term") then
					vim.cmd("startinsert")
				end
			end,
		})
	end
	C.setup_startinsert_in_terminal = function()
		vim.defer_fn(setup_startinsert_in_terminal, 500)
	end

	C.disable_number_in_terminal = function()
		vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])
	end
end

_M["mappings.base"] = function(C)
	C["t"]["jj"] = "<C-\\><C-n>"
	C["t"]["<C-w>j"] = "<C-\\><C-n><C-w>j"
	C["t"]["<C-w>h"] = "<C-\\><C-n><C-w>h"
	C["t"]["<C-w>k"] = "<C-\\><C-n><C-w>k"
	C["t"]["<C-w>l"] = "<C-\\><C-n><C-w>l"
	C["t"]["gt"] = "<C-\\><C-n><cmd>tabn<cr>"
	C["t"]["gT"] = "<C-\\><C-n><cmd>tabN<cr>"
	C["n"]["<leader>tt"] = "<cmd>tabnew<cr><bar><cmd>terminal<cr>i"
	C["n"]["<leader>tx"] = "<cmd>sp<cr><bar><cmd>terminal<cr>i"
	C["n"]["<leader>tv"] = "<cmd>vsp<cr><bar><cmd>terminal<cr>i"

	-- This keymap is not defalut. To avoid that your term is killed and you don't know what have happened. or you can try delete(0,false). 
	-- C["t"]["<leader>bd"] = "<cmd>lua require('mini.bufremove').delete(0,true)<cr>"
end

require("core").register_override_config(_M)
