local utils = require("core.utils")
local override = require("core.override")
local keymap = require("core.keymap")
require("core.cmd")

return {
	register_override_config = override.register_override_config,
	merge_configs = override.merge_configs,
	vim_version = utils.vim_version,
	create_default_table = utils.create_default_table,
	create_empty_function = utils.create_empty_function,
	call = utils.call,
	keymap_opts = keymap.keymap_opts,
	get_keymap_empty_bucket = keymap.get_keymap_empty_bucket,
	set_keymap_bucket = keymap.set_keymap_bucket,
}
