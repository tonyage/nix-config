local dusk = {}
local gradients = {}

gradients.dark = {
  black   = "#000000",
  black00 = "#161616",
  black05 = "#222222",
  black10 = "#2d2d2d",
  black15 = "#393939",
  black20 = "#454545",
  black25 = "#505050",
  black90 = "#707070",
}

gradients.light = {
  white   = "#ffffff",
  white00 = "#abb2bf",
  white05 = "#b5bcc9",
  white10 = "#b9bfcc",
  white15 = "#bcc3ce",
  white20 = "#c4c9d4",
  white25 = "#c7cdd6",
  white91 = "#f8f8fa",
}

dusk.normal = {
  black   = "#161616",
  red     = "#e54f65",
  green   = "#89ca78",
  yellow  = "#e5c07b",
  blue    = "#61afef",
  magenta = "#c678dd",
  cyan    = "#60c0cc",
  white   = "#abb2bf",
  orange  = "#ea9560",
  pink    = "#de8c92",

  grey00  = "#393939",
  grey01  = "#454545",
  grey02  = "#565656",

  base00  = "#161616",
  base01  = "#222222",
  base02  = "#2d2d2d",
  base03  = "#393939",
  base04  = "#454545",
  base05  = "#505050",
  base06  = "#abb2bf",
  base07  = "#b5bcc9",
  base08  = "#e07c75",
  base09  = "#ea9560",
  base0A  = "#e6c07b",
  base0B  = "#89ca78",
  base0C  = "#60c0cc",
  base0D  = "#61afef",
  base0E  = "#c678dd",
  base0F  = "#f44747",

  dark    = gradients.dark,
  light   = gradients.light,
}

dusk.vivid = {
  gradients,
  black   = "#161616",
  red     = "#ef596f",
  green   = "#93d482",
  yellow  = "#efca85",
  blue    = "#6bb9f9",
  magenta = "#d55fde",
  cyan    = "#60c0cc",
  white   = "#b5bcc9",
  orange  = "#f49f6a",
  pink    = "#e8969c",
  error   = "#f44747",

  grey00  = "#393939",
  grey01  = "#454545",
  grey02  = "#565656",

  base00  = "#161616",
  base01  = "#222222",
  base02  = "#2d2d2d",
  base03  = "#393939",
  base04  = "#454545",
  base05  = "#505050",
  base06  = "#abb2bf",
  base07  = "#b5bcc9",
  base08  = "#ef596f",
  base09  = "#ea9560",
  base0A  = "#e5c07b",
  base0B  = "#89ca78",
  base0C  = "#60c0cc",
  base0D  = "#6bb9f9",
  base0E  = "#d55fde",
  base0F  = "#f44747",

  dark    = gradients.dark,
  light   = gradients.light,
}

vim.opt.bg = "dark"

return dusk

