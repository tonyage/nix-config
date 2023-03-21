local M = {}

M.hl_rounded_borders = function(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

M.hl_square_borders = function(hl_name)
  return {
    { "⎡", hl_name },
    { "─", hl_name },
    { "⎤", hl_name },
    { "│", hl_name },
    { "⎦", hl_name },
    { "─", hl_name },
    { "⎣", hl_name },
    { "│", hl_name },
  }
end

M.hl_borders = function(hl_name)
  return {
    { "🭽", hl_name },
    { "▔", hl_name },
    { "🭾", hl_name },
    { "▕", hl_name },
    { "🭿", hl_name },
    { "▁", hl_name },
    { "🭼", hl_name },
    { "▏", hl_name },
  }
end

M.rounded_borders = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

M.square_borders = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

M.hover = {
  border = "single",
  close_events = { "BufLeave", "CursorMoved", "InsertLeave", "FocusLost" },
  focusable = false,
  relative = "cursor",
  source = "always",
  scope = "cursor",
  prefix = " ",
  anchor = "SW",
  row = 0,
  col = 0,
}

return M

