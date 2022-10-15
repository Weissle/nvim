# **Yue**
A neovim framework for C, C++, Python and Lua.  
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
|**lua/core/** | The core of **Yue**.  
|**lua/setting/** | The common and basic setting.  
|**lua/mappings/** | The common and plugins' specific keymaps.  
|**lua/plugins/plugins.lua** | All used plugins are declared here.  
|**lua/plugins/setup/** | The plugins' setup function.  
|**lua/experiments/** | Experiments features are placed here. They are disabled by default. Check the `init.lua` if you want them.

### Create you config
If you want to change something, find the relative part firstly.
You should see its default config and something like `require("core").merge_config(M, "{config_name}")`.
To override the content of M, you should create a function accept the M, and change it inside the function.  
Here is an example how to employ your config to **Yue**'s.
By default, LSP and treesitter support lua, c/c++ and python language.
Assuming we need golang's LSP and treesitter.
```lua
-- lua/custom/init.lua
my_config = {}

-- The config of treesitter in lua/plugins/setup/treesitter.lua 
-- We should add `python` to the config.ensure_installed field
my_config["plugins.setup.treesitter"] = function(C)
	table.insert(C.config.ensure_installed,"go")
	-- C.config.ensure_installed = {"lua", "cpp", "python", "go"} works too.
end

-- The config of LSP in lua/plugins/setup/lspconfig.lua 
-- Let us use `pyright` as python LSP server.
my_config["plugins.setup.lspconfig"] = function(C)
	C.config.lsp_servers = {"sumneko_lua", "clangd", "pyright", "gopls"}
end

-- Let **Yue** know your config
require("core").register_override_config(my_config)
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
