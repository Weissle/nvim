# **Yue**
A Neovim framework.
**If you see this sentence, it means that **Yue** is not totally ready.
It should be placed to a new repo.**

## Features
:book: LSP, Completion, Debug, Beautiful UI...  
:gear: Easy to config and almost all config can be changed.  
:dash: Backward compatibility. Support Neovim >= 0.7.0. (The plugins require neovim >= 0.8.0 will be disable automatically.)

## **Yue** is for?
* For user who just begin to use neovim, **Yue** directly provides rich features and saves your precious time.
* For user who are already having your own config or using other framework, **Yue** is a good reference for improving your vim experience. 

## How to use **Yue**?
<!-- 1. clone this repo to your `~/.config/nvim`. -->
<!-- 2. Run "YuePluginsSync" in neovim to install the plugins. -->
<!-- 3. Create your config if you need. -->

### Walk Through
| Folder or File | Usage |
| -- | -- |
|**lua/custom/** | Place your config here.  
|**lua/core/** | The core of **Yue**. Usually you don't need to change it.
|**lua/setting/** | The common and basic setting.  
|**lua/mappings/** | The common and plugins' specific keymaps.  
|**lua/plugins/plugins.lua** | All used plugins are declared here.  
|**lua/plugins/setup/** | The plugins' setup function.  
|**lua/options/** | Some predefined but not used config. You can use or not.
|**lua/experiments/** | Experiments features are placed here. They are disabled by default as well as the config in options.

### Create you config
If you want to change something, find the relative part firstly.
You should see its default config and something like `require("core").merge_configs(M, "{config_name}")`.
To override the content of M, you should create a function accept the M, and change it inside the function.  
Below is an example to show how to add the support of golang by changing the lspconfig's and treesitter's config.
Assuming we need golang's LSP and treesitter.
```lua
-- For language golang.
local _M = {
	-- use gopls as the go LSP server.
	-- See file lua/plugins/setup/lspconfig.lua and nvim-lspconfig's github repo for more information.
	["plugins.setup.lspconfig"] = function(C)
		table.insert(C.lsp_servers, "gopls")
	end,
	-- golang highlight.
	-- See file lua/plugins/setup/treesitter.lua and nvim-treesitter's github repo for more information.
	["plugins.setup.treesitter"] = function(C)
		table.insert(C.config.ensure_installed, "go")
	end,
}
-- let Yue know your config.
require("core").register_override_config(_M)
```

You can also use a `table` to override the default config.
But this way is not recommended. Since using function
1. You can return a totally new config rather than change the original config.
	```lua
	my_config["settings.opt"] = function(C)
		-- the opt table is replaced by the {}.
		return {} 
	end
	```
2. Avoid the missing module problem.
Some plugins are lazy loaded and the runtime paths don't include their path at first.
In function, these modules are required when the function is called.

### Use the Optional config
```lua
-- file: lua/custom/init.lua
-- use experimental feature.
require("experiments")
-- use lua/plugins/options/python.lua
require("options.language.python")
-- then write and register your config
```

### The Priority of Different Override Config.
The later registered config have higher priority.
```lua
--[[
M = {
	a = 3,
	b = {1,2}
}
require("core").merge_configs(M, "somthing")
]]
local _M1 = {
	["something"] = function(C) 
		C.a = 1
		table.insert(C.b,5)
	end
}
require("core").register_override_config(_M1)
local _M2 = {
	["something"] = function(C) 
		C.a = 2
		table.insert(C.b,4)
	end
}
require("core").register_override_config(_M2)
--[[
_M1["somthing"](somthing) is called firstly.
Then _M2["somthing"](somthing) is called.
Finnaly, 
somthing = {
	a = 2,
	b = {1,2,5,4}
}
]]
```
## You May Ask
* **A startup plugin?**  
Since we have the session manager plugin, the startup page is redundant.

## About **Yue**.
**Yue** was my neovim config but not a framework at first.
After I transferred from vimscript to lua (Jun 2022),
I spent time on it and tried to make it better and better.
Four months past (Oct 2022), **Yue** fits my requirements now
and I believe it can be better if more people use it.
I do appreciate anyone who try it, use it and give me the feedback.


## TODO
- [] https://github.com/nvim-pack/nvim-spectre/issues/93
