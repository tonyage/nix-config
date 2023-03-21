local colors = require("ui.themer").colorscheme("vivid")
require("lspconfig.ui.windows").default_options.border = "single"
return {
	LspReferenceText = { fg = colors.black, bg = colors.white },
	LspReferenceRead = { fg = colors.black, bg = colors.white },
	LspReferenceWrite = { fg = colors.black, bg = colors.white },
	LspInfoTitle = { fg = colors.green, bold = true },
	LspInfoTips = { bg = colors.black },
	LspInfoList = { fg = colors.cyan },
	LspInfoFiletype = { fg = colors.orange },
	LspInfoBorder = { fg = colors.dark.black90 },
	DiagnosticHint = { fg = colors.magenta },
	DiagnosticError = { fg = colors.red },
	DiagnosticWarn = { fg = colors.yellow },
	DiagnosticInfo = { fg = colors.green },
	DiagnosticFloatingHint = { fg = colors.magenta },
	DiagnosticFloatingError = { fg = colors.red },
	DiagnosticFloatingWarn = { fg = colors.yellow },
	DiagnosticFloatingInfo = { fg = colors.green },
	LspSignatureActiveParameter = { fg = colors.black, bg = colors.orange },
}
