require("ui.themer").highlight("git")
local key = require("main.mappings")
local windows = require("ui.windows")
return {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 150
  },
  preview_config = windows.not_focusable,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    key.map("n", "<leader>cn", function()
      if vim.wo.diff then return "<leader>cn" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true, buffer = bufnr })
    key.map("n", "<leader>cb", function()
      if vim.wo.diff then return "<leader>cb" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true, buffer = bufnr })
    key.map("n", "<leader>dt", gs.diffthis)
    key.map("n", "<leader>sh", function() gs.stage_hunk() end)
    key.map("n", "<leader>rh", function() gs.reset_hunk() end)
    key.map("n", "<leader>ph", function() gs.preview_hunk() end)
    key.map("n", "<leader>bl", function() gs.blame_line({ full = true }) end)
    key.map("n", "<leader>td", function() gs.toggle_deleted() end)
  end
}

