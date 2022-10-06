# Yue
Yep. Another neovim framework. 
---

## Features
1. LSP, Completion, ...(I believe other frameworks have them too.)
2. Easy to config.
3. Fast starts up.

## Yue is for?
* For user who just begin to use neovim, Yue directly provides rich features and saves your precious time.
* For user who are already having your own config or using other framework, Yue is a good reference for improving your vim experience. 

## How to use Yue?
1. clone this repo to your `~/.config/nvim`.

### Walk Through
**lua/custom/**: Place your config in here.
**lua/core/**: The core of Yue.
**lua/mappings/**: The common and plugins' specific keymaps.
**lua/plugins/plugins.lua**: All used plugins are declared here.
**lua/plugins/setup/**: The plugins' setup function.
**lua/setting/**: The common and basic setting.

### Create you config.
If you want to change something, find the relative part first.
You should see its default config and `require("core").merge_config(X, "{config_name}")`
For example, the vim option `relativenumber` ad `number` is set to `true` in Yue.
If you don't like it, you can change.
You should see `opt = core.merge_configs(opt, "settings.opt")` in the file `lua/settings/init.lua` as well as `opt.relativenumber = true` and `opt.number = true`.
You have two ways to override the `opt`, function (highly recommand) or table.
1. function
```lua
my_config["settings.opt"] = function(C)
	C.relativenumber = false
	C.number = false
end
```

2. table
```lua
my_config["settings.opt"] = {
	relativenumber = false,
	number = true,
}
```

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

### Register you config.
`require("core").register_override_config(my_config)`.  
It's all right if you register more than one config. 
The late registered config have higher priority.


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

