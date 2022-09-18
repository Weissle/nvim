local core = require("core")

local opt = {}
local global = {}

opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.cursorline = true
opt.termguicolors = true
opt.smartcase = true
opt.ignorecase = true
opt.guicursor = "n-v-c-sm:blinkon01,i-ci-ve:ver25-blinkon01,r-cr-o:hor20"
opt.jumpoptions = "stack"
opt.splitright = true
opt.splitbelow = true
opt.incsearch = false
opt.fixeol = false
global.mapleader = " "
-- global.auto_session_enabled = false

opt = core.merge_user_config(opt, "settings.opt")
global = core.merge_user_config(global, "settings.global")

for k, v in pairs(opt) do
	vim.o[k] = v
end
for k, v in pairs(global) do
	vim.g[k] = v
end

for _, v in pairs(require("settings.functions")) do
	v()
end
