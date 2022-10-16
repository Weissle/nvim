-- plugins may override other plugins' config.
require("plugins.override")

-- your custom config
require("custom")

require("settings")
-- impatient slow down startup when we don't use auto-session
if vim.g.auto_session_enabled ~= false then
	pcall(require, "impatient")
end

require("mappings")
