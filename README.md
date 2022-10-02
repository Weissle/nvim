# Yue
Yep. Another neovim framework. 
---

## Yue is for?
* For user who just begin to use neovim, Yue directly provides rich features and saves your precious time.
* For user who are already having your own config or using other framework, Yue is a good reference for improving your vim experience. 

## How to use Yue?

### Walk Through
```
├── init.lua
├── lua
│   ├── core
│   │   └── init.lua
│   ├── custom
│   │   ├── init.lua
│   │   └── utils.lua
│   ├── mappings
│   │   ├── init.lua
│   │   ├── plugin_after.lua
│   │   ├── plugin_builtin.lua
│   │   └── plugin_preset.lua
│   ├── plugins
│   │   ├── config.lua
│   │   ├── plugins.lua
│   │   └── setup
│   └── settings
│       ├── functions.lua
│       └── init.lua
```
**lua/custom**: Place your config in here.
**lua/mappings/init.lua**: Basic keymap.
**lua/mappings/plugin_after.lua**: The keymaps are set after the relevant plugin is loaded.
**lua/mappings/plugin_builtin.lua**: Set the keymap through the plugins rather than ourselves.
**lua/mappings/plugin_preset.lua**: The keymaps are set if the relevant plugin exists. Usually they are used for the lazy loading.
**lua/plugins/config.lua**: The config used for the plugins.
**lua/plugins/plugins.lua**: All used plugins are declared here.
**lua/plugins/setup**: The plugins' setup function.
**lua/setting/init.lua**: Basic setting.
**lua/setting/functions.lua**: The functions used to setup

## About Yue.
Yue was my neovim config but not a framework at first.
After I transferred from vimscript to lua (Jun 2022),
I spent time on it and tried to make it better and better.
Four months past (Oct 2022), Yue fits my requirements now
and I believe it can be better if more people use it.
I do appreciate anyone who try it, use it and give me the feedback.

## TODO
- [ ] About Hop:https://github.com/phaazon/hop.nvim/pull/314

