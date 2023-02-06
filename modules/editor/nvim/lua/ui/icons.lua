local M = {}

M.lspkind = {
  Calendar = "",
  Character = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Copilot = "",
  Boolean = "",
  Class = "ﴯ",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "ﰠ",
  File = "",
  Folder = "",
  Function = "ﬦ",
  Interface = "",
  Keyword = "",
  Method = "",
  Module = "",
  Namespace = "",
  Null = "ﳠ",
  Number = "",
  Object = "",
  Operator = "",
  Package = "",
  Property = "ﰠ",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "פּ",
  Table = "",
  Tag = "",
  TypeParameter = "",
  Text = "",
  Unit = "塞",
  Value = "",
  Variable = "",
  Watch = "",
}

M.lsp = {
  error = {
    name = "Error",
    icon = "",
  },

  info = {
    name = "Info",
    icon = "",
  },

  hint = {
    name = "Hint",
    icon = "", },

  warn = {
    name = "Warn",
    icon = ""
  },
}

M.statusline_separators = {
  default = {
    left = "",
    right = " ",
  },

  round = {
    left = "",
    right = "",
  },

  block = {
    left = "█",
    right = "█",
  },

  arrow = {
    left = "",
    right = "",
  },
}

M.winbar = {
  separator = {
    light = {
      left = "⟨",
      right = "⟩"
    },
    medium = {
      left = "❬",
      right = "❭",
    },
  },
}

M.devicons = {
  default_icon = {
    icon = "",
    name = "Default",
  },

  c = {
    icon = "",
    name = "c",
  },

  css = {
    icon = "",
    name = "css",
  },

  deb = {
    icon = "",
    name = "deb",
  },

  Dockerfile = {
    icon = "",
    name = "Dockerfile",
  },

  html = {
    icon = "",
    name = "html",
  },

  jpeg = {
    icon = "",
    name = "jpeg",
  },

  jpg = {
    icon = "",
    name = "jpg",
  },

  js = {
    icon = "",
    name = "js",
  },

  kt = {
    icon = "󱈙",
    name = "kt",
  },

  lock = {
    icon = "",
    name = "lock",
  },

  lua = {
    icon = "",
    name = "lua",
  },

  mp3 = {
    icon = "",
    name = "mp3",
  },

  mp4 = {
    icon = "",
    name = "mp4",
  },

  out = {
    icon = "",
    name = "out",
  },

  png = {
    icon = "",
    name = "png",
  },

  py = {
    icon = "",
    name = "py",
  },

  ["robots.txt"] = {
    icon = "ﮧ",
    name = "robots",
  },

  toml = {
    icon = "",
    name = "toml",
  },

  ts = {
    icon = "ﯤ",
    name = "ts",
  },

  ttf = {
    icon = "",
    name = "TrueTypeFont",
  },

  rb = {
    icon = "",
    name = "rb",
  },

  rpm = {
    icon = "",
    name = "rpm",
  },

  vue = {
    icon = "﵂",
    name = "vue",
  },

  woff = {
    icon = "",
    name = "WebOpenFontFormat",
  },

  woff2 = {
    icon = "",
    name = "WebOpenFontFormat2",
  },

  xz = {
    icon = "",
    name = "xz",
  },

  zip = {
    icon = "",
    name = "zip",
  },
}

return M

