local colors = require("ui.themer").colorscheme("vivid")

return {
  NeoTreeNormal = { bg = colors.dark.black05 },
  NeoTreePreview = { bg = colors.dark.black05 },
  NeoTreeFilterTerm = { bg = colors.dark.black10 },
  NeoTreeWinSeparator = { bg = colors.black, fg = colors.black },
  NeoTreeModified = { fg = colors.orange },
  NeoTreeTabActive = { bg = colors.dark.black05 },
  NeoTreeTabInactive = { bg = colors.black },
  NeoTreeTabSeparatorActive = { bg = colors.dark.black05, fg = colors.dark.black05},
  NeoTreeTabSeparatorInactive = { bg = colors.black, fg = colors.black },
}

