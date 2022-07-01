local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
--
dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

local pwd = vim.fn.getcwd()

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>", nil),
    dashboard.button( "f", "  > Find file", string.format(":cd %s | Telescope find_files<CR>",pwd), nil),
    dashboard.button( "g", "  > Grep string", string.format(":cd %s | Telescope live_grep<CR>",pwd), nil),
    dashboard.button( "o", "  > Recent"   , ":Telescope oldfiles<CR>", nil),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>", nil),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
