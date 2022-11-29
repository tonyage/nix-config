require("ui.themer").load()
require("ui.components.cmp")
require("ui.components.git")
require("ui.components.devicons")
require("ui.components.treesitter")
require("ui.components.telescope")
require("ui.components.blankline")
require("ui.components.nvimtree")
require("ui.components.whichkey")

vim.opt.statusline = "%!v:lua.require('ui.components.statusline').setup()"

