local M = {}
local sections = require("ui.statusline.sections")

function M.setup()
  return table.concat {
    sections.mode(),
    sections.git(),
    sections.cwd(),
    "%=",
    "%#StatusLine#",
    sections.progress() or "",
    "%#StatusLine#",
    "%=",
    sections.diagnostics(),
    sections.lsp_status() or "",
    sections.file_info(),
    sections.updates(),
  }
end

return M

