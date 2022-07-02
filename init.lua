local present, impatient = pcall(require, "impatient")

if present then
   impatient.enable_profile()
end

require('settings')
require('plugins.plugins')
require('mappings.mappings')
