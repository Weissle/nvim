local core = require("core")

------------------------------------SPLIT--------------------------------------------------------
local opt = {}
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
opt = core.merge_configs(opt, "settings.opt")
for k, v in pairs(opt) do
	vim.o[k] = v
end

------------------------------------SPLIT--------------------------------------------------------
local global = {}
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1
global.loaded_node_provider = 0
global.loaded_perl_provider = 0
global.loaded_python3_provider = 0
global.loaded_ruby_provider = 0

-- global.auto_session_enabled = false
global = core.merge_configs(global, "settings.global")
for k, v in pairs(global) do
	vim.g[k] = v
end

------------------------------------SPLIT--------------------------------------------------------
core.call(require("settings.functions"))
