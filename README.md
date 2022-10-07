# Yue
Yep. Another neovim framework. 

## Features
:book: LSP, Completion, Beautiful UI...  
:cake: Easy to config.  
:gear: Almost all config can be changed.  
:zap: Fast starts up.  
:electric_plug: Removing the plugins is painless. (All the relative keymaps and settings are gone if a plugin is disabled.)

## Yue is for?
* For user who just begin to use neovim, Yue directly provides rich features and saves your precious time.
* For user who are already having your own config or using other framework, Yue is a good reference for improving your vim experience. 

## How to use Yue?
<!-- 1. clone this repo to your `~/.config/nvim`. -->
<!-- 2. create your config. -->

### Walk Through
| Folder or File | Usage |
| -- | -- |
|**lua/custom/** | Place your config here.  
|**lua/core/** | The core of Yue.  
|**lua/setting/** | The common and basic setting.  
|**lua/mappings/** | The common and plugins' specific keymaps.  
|**lua/plugins/plugins.lua** | All used plugins are declared here.  
|**lua/plugins/setup/** | The plugins' setup function.  

### Create you config
If you want to change something, find the relative part firstly.
You should see its default config and something like `require("core").merge_config(M, "{config_name}")`.
To override the content of M, you should create a function accept the M, and change it inside the function.  
Here is an example how to employ your config to Yue's.
By default, LSP and treesitter only support lua language.
Assuming we need python's LSP and treesitter.
```lua
-- lua/custom/init.lua
my_config = {}

-- The config of treesitter in lua/plugins/setup/treesitter.lua 
-- We should add `python` to the config.ensure_installed field
my_config["plugins.setup.treesitter"] = function(C)
	table.insert(C.config.ensure_installed,"python")
	-- C.config.ensure_installed = {"lua", "python"} works too.
end

-- The config of LSP in lua/plugins/setup/lspconfig.lua 
-- Let us use `pyright` as python LSP server.
my_config["plugins.setup.lspconfig"] = function(C)
	C.config.lsp_servers = {"sumneko_lua", "pyright"}
end

-- Let Yue know your config
require("core").register_override_config(my_config)
```

You can also use a `table` to override the default config.
But this way is not recommended.
The advantages of using function:
1. You can return a totally new config rather than change the original config.
```lua
my_config["settings.opt"] = function(C)
	-- the opt table is replaced by the {}.
	return {} 
end
```
2. Avoid the missing module problem.
Some plugins are lazy loaded and the runtime paths don't include their path at first.
Require them in the table meets errors.
In function, these modules are required when the function is called.

## About Yue.
Yue was my neovim config but not a framework at first.
After I transferred from vimscript to lua (Jun 2022),
I spent time on it and tried to make it better and better.
Four months past (Oct 2022), Yue fits my requirements now
and I believe it can be better if more people use it.
I do appreciate anyone who try it, use it and give me the feedback.

## TODO
- [ ] About Hop:https://github.com/phaazon/hop.nvim/pull/314
- [ ] If we use all buffer as the source of `cmp-buffer`, `dd` becomes slowly.

