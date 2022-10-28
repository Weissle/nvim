local _M = {}
local continue_chars = "0123456789ia"
local char1_chars = "(){}[]<>`'\""

local function char_in_str(c, s)
	for i = 1, #s do
		if c == string.sub(s, i, i) then
			return true
		end
	end
	return false
end

local function equal(a, b)
	if type(a) ~= type(b) then
		return false
	elseif type(a) == "table" then
		if #a ~= #b then
			return false
		else
			for k, v in pairs(a) do
				if equal(v, b[k]) == false then
					return false
				end
			end
		end
		return true
	else
		return a == b
	end
end

local function action_input()
	local lst_char, cmd = "0", ""
	while char_in_str(lst_char, continue_chars) do
		lst_char = vim.fn.getcharstr()
		if lst_char == "" then
			return ""
		end
		cmd = cmd .. lst_char
	end
	print("return")
	return cmd
end

local function do_jump(last_char)
	if last_char == "b" then
		last_char = "("
	end
	if char_in_str(last_char, char1_chars) then
		vim.defer_fn(function()
			vim.api.nvim_feedkeys(last_char, "n", true)
		end, 1)
		vim.cmd("HopChar1MW")
	else
		vim.cmd("HopWordMW")
	end
end

local function _work(cmd)
	local win_handle = vim.api.nvim_get_current_win()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	do_jump(cmd:sub(#cmd))
	if win_handle == vim.api.nvim_get_current_win() and equal(cursor_pos, vim.api.nvim_win_get_cursor(0)) then
		return
	end
	vim.cmd("normal " .. cmd)
	vim.defer_fn(function()
		vim.api.nvim_set_current_win(win_handle)
		vim.api.nvim_win_set_cursor(win_handle, cursor_pos)
	end, 1)
end

local function work(m)
	local async = require("async")
	local cmd = action_input()
	print("input cmd", cmd)
	if cmd == "" then
		return
	end
	async(function()
		_work(m .. cmd)
	end)
end

_M["mappings.plugin"] = function(C)
	C["n"][";y"] = {
		function()
			work("y")
		end,
	}
	C["n"][";d"] = {
		function()
			work("d")
		end,
	}
end

require("core").register_override_config(_M)
