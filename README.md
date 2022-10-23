# **Yue**
A Neovim framework.  
**If you see this sentence, it means that **Yue** is not totally ready.
It should be placed to a new repo.**

## Features
:book: LSP, Completion, Fuzzy Search, Debug, Beautiful UI...  
:gear: Easy to config and almost all config can be changed.  
:dash: Backward compatibility. Support Neovim >= 0.7.0.  
:keyboard: Keymaps are reasonable and easy to remember.

## **Yue** is for?
* For user who just begin to use neovim, **Yue** directly provides rich features and saves your precious time.
* For user who are already having your own config or using other framework, **Yue** is a good reference for improving your vim experience. 


## How to use **Yue**?
1. clone this repo to your `~/.config/nvim`.
`git clone https://github.com/YueNvim/Yue.git ~/.config/nvim`
2. Run command `YuePluginsSync` in `neovim` to install the plugins.
3. Create your config if you need. Check the `Create your config` section.

**Walk Through**
| Folder or File | Usage |
| -- | -- |
|**lua/custom/** | Place your config here.  
|**lua/core/** | The core of **Yue**. Usually you don't need to change it.
|**lua/setting/** | The common and basic setting.  
|**lua/mappings/** | The common and plugins' specific keymaps.  
|**lua/plugins/plugins.lua** | All used plugins are declared here.  
|**lua/plugins/setup_config.h** <br> **lua/plugins/setup/**| Plugins' setuping config.|
|**lua/options/** | Some predefined but not loaded config.
|**lua/experiments/** | Experiments features are placed here.

## Create your config
### Basic
```lua
-- custom/init.lua
-- To use experimental feature
require("experiments")

-- Check lua/options for more optional config.
-- For C/C++ language
require("options.language.c_cpp")
-- For Python language
require("options.language.python")
```
### Advanced
If you want to change something, find the relative part firstly.
You should see its default config and something like `require("core").merge_configs(M, "{config_name}")`.
To override the content of M, you should create a function accepts the `M`, and change `M` inside the function. I believe files under `lua/options/` and `lua/experiments/` are good examples.

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

### The Priority of Different Override Config.
The later registered config have higher priority.
```lua
--[[ somewhere,
M = {a = 3,	b = {1,2}}
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
Finnaly:
somthing = {
	a = 2,
	b = {1,2,5,4}
}
]]
```

## Contribution
1. **Bug Fixed**: Modify the original files directly (of course, on your branch). Please provide enough details about the bug including its root cause or how to reproduce it.
2. **New Feature**: Create a lua file, place it to `lua/experiments/` and indicate its' target place, `options` or **Yue**'s main part. Please make sure that user should almost no need to change their config after the new feature is merged. 

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
- [ ] https://github.com/nvim-pack/nvim-spectre/issues/93
- [ ] https://github.com/neovim/neovim/pull/17446#pullrequestreview-1103134678
