local colors = require("ui.themer").colorscheme("vivid")

return {

  ["@annotation"] = { fg = colors.yellow, italic = true },
  ["@attribute"] = { fg = colors.yellow },
  ["@character"] = { fg = colors.orange },
  ["@constructor"] = { fg = colors.yellow, bold = true },

  ["@constant"] = { fg = colors.orange, bold = true },
  ["@constant.builtin"] = { fg = colors.orange, italic = true },
  ["@constant.macro"] = { fg = colors.orange, bold = true },

  ["@define"] = { fg = colors.magenta, sp = "none" },
  ["@prepoc"] = { fg = colors.magenta },
  ["@repeat"] = { fg = colors.yellow },

  ["@error"] = { fg = colors.error },
  ["@exception"] = { fg = colors.error },

  ["@keyword"] = { fg = colors.magenta, bold = true, italic = true },
  ["@keyword.function"] = { fg = colors.magenta, bold = true, italic = true },
  ["@keyword.return"] = { fg = colors.magenta, bold = true, italic = true },
  ["@keyword.operator"] = { fg = colors.magenta },

  ["@function"] = { fg = colors.blue },
  ["@function.builtin"] = { fg = colors.blue, italic = true },
  ["@function.macro"] = { fg = colors.blue, bold = true },

  ["@label"] = { fg = colors.red, bold = true },
  ["@number"] = { fg = colors.orange },
  ["@float"] = { link = "@number" },
  ["@boolean"] = { fg = colors.magenta, italic = true },

  ["@method"] = { fg = colors.blue },
  ["@property"] = { fg = colors.cyan },
  ["@namespace"] = { fg = colors.magenta },
  ["@none"] = { fg = colors.base05 },
  ["@parameter"] = { fg = colors.orange },
  ["@parameter.reference"] = { fg = colors.light.white05 },
  ["@reference"] = { fg = colors.light.white05 },

  ["@punctuation"] = { fg = colors.white },
  ["@punctuation.bracket"] = { fg = colors.white },
  ["@punctuation.special"] = { fg = colors.red },
  ["@operator"] = { fg = colors.light.white05, sp = "none" },

  ["@string"] = { fg = colors.green, italic = true },
  ["@string.regex"] = { fg = colors.orange },
  ["@string.escape"] = { fg = colors.red },
  ["@structure"] = { fg = colors.magenta, bold = true },
  ["@storageclass"] = { fg = colors.yellow },

  ["@symbol"] = { fg = colors.cyan },

  ["@tag"] = { fg = colors.yellow },
  ["@tag.attribute"] = { link = "@property" },
  ["@tag.delimiter"] = { fg = colors.error },

  ["@text"] = { fg = colors.light.white05 },
  ["@text.strong"] = { bold = true },
  ["@text.emphasis"] = { fg = colors.orange, italic = true },
  ["@text.strike"] = { fg = colors.black, strikethrough = true },
  ["@text.literal"] = { fg = colors.green, italic = true },
  ["@text.uri"] = { fg = colors.orange, underline = true },
  ["@text.reference"] = { fg = colors.orange },
  ["@text.todo"] = { fg = colors.orange, bold = true },

  ["@type"] = { fg = colors.orange, sp = "none", bold = true },
  ["@type.builtin"] = { fg = colors.orange, italic = true },
  ["@type.defintion"] = { fg = colors.orange, sp = "none", bold = true, italic = true },

  ["@variable"] = { fg = colors.light.white05 },
  ["@variable.builtin"] = { fg = colors.orange },

  ["@definition"] = { fg = colors.light.white05, underline = true },
  ["@scope"] = { bold = true },
  ["@field"] = { fg = colors.red },
  ["@include"] = { fg = colors.magenta, italic = true },
  ["@conditional"] = { fg = colors.magenta, italic = true },
}

