local colors = require("ui.themer").colorscheme("vivid")

return {
  StatusLine = { bg = colors.dark.black05 },

  git_branch = { fg = colors.white, bg = colors.dark.black10, bold = true },
  git_added = { fg = colors.green, bg = colors.dark.black10, bold = true },
  git_changed = { fg = colors.yellow, bg = colors.dark.black10, bold = true },
  git_removed = { fg = colors.red, bg = colors.dark.black10, bold = true },
  git_sep = { fg = colors.dark.black10, bg = colors.dark.black05 },

  lsp_error = { fg = colors.error, bg = colors.dark.black05 },
  lsp_warning = { fg = colors.orange, bg = colors.dark.black05 },
  lsp_hints = { fg = colors.magenta, bg = colors.dark.black05 },
  lsp_info = { fg = colors.green, bg = colors.dark.black05 },
  lsp_progress = { fg = colors.green, bg = colors.dark.black05 },
  lsp_sep = { fg = colors.red, bg = colors.dark.black05 },
  lsp_icon = { fg = colors.black, bg = colors.red },
  lsp_text = { fg = colors.red, bg = colors.dark.black05 },

  NormalMode = { bg = colors.blue, fg = colors.black, bold = true },
  InsertMode = { bg = colors.magenta, fg = colors.black, bold = true },
  TerminalMode = { bg = colors.green, fg = colors.black, bold = true },
  NTerminalMode = { bg = colors.yellow, fg = colors.black, bold = true },
  VisualMode = { bg = colors.cyan, fg = colors.black, bold = true },
  ReplaceMode = { bg = colors.orange, fg = colors.black, bold = true },
  ConfirmMode = { bg = colors.teal, fg = colors.black, bold = true },
  CommandMode = { bg = colors.green, fg = colors.black, bold = true },
  SelectMode = { bg = colors.blue, fg = colors.black, bold = true },

  NormalModeSep = { fg = colors.blue, bg = colors.dark.black15 },
  InsertModeSep = { fg = colors.magenta, bg = colors.dark.black15 },
  TerminalModeSep = { fg = colors.green, bg = colors.dark.black15 },
  NTerminalModeSep = { fg = colors.yellow, bg = colors.dark.black15 },
  VisualModeSep = { fg = colors.cyan, bg = colors.dark.black15 },
  ReplaceModeSep = { fg = colors.orange, bg = colors.dark.black15 },
  ConfirmModeSep = { fg = colors.teal, bg = colors.dark.black15 },
  CommandModeSep = { fg = colors.green, bg = colors.dark.black15 },
  SelectModeSep = { fg = colors.blue, bg = colors.dark.black15 },

  buffer = { fg = colors.dark.black15, bg = colors.dark.black10 },

  file_info = { fg = colors.white, bg = colors.dark.black10 },
  file_sep = { fg = colors.dark.black10, bg = colors.dark.black05 },
  cwd_icon = { fg = colors.magenta, bg = colors.dark.black05 },
  cwd_text = { fg = colors.dark.black25, bg = colors.dark.black05 },
  cwd_sep = { fg = colors.dark.black05, bg = colors.dark.black05 },
  pos_sep = { fg = colors.green, bg = colors.dark.black05 },
  pos_icon = { fg = colors.black, bg = colors.green },
  pos_text = { fg = colors.green, bg = colors.dark.black05 },
  updates = { fg = colors.black, bg = colors.orange, bold = true },
  block_sep = { fg = colors.orange, bg = colors.orange }
}
