local key = require("main.mappings")
local windows = require("ui.windows")
local navic = require("nvim-navic")

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cursorline = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cursorline then
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cursorline = vim.wo.cursorline
    local cursorcolumn = vim.wo.cursorcolumn
    if cursorline and cursorcolumn then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cursorline)
      vim.wo.cursorline = false
      vim.wo.cursorcolumn = false
    end
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local opts = { noremap = true, silent = true, buffer = event.buf }
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    key.map("n", "gD", vim.lsp.buf.declaration, opts)
    key.map("n", "gd", vim.lsp.buf.definition, opts)
    key.map("n", "gk", vim.lsp.buf.hover, opts)
    key.map("n", "gi", vim.lsp.buf.implementation, opts)
    key.map("n", "gr", require("telescope.builtin").lsp_references, opts)
    key.map("n", "gsh", vim.lsp.buf.signature_help, opts)
    key.map("n", "gt", vim.lsp.buf.type_definition, opts)
    key.map("n", "gca", vim.lsp.buf.code_action, opts)
    key.map("n", "gfm", function() vim.lsp.buf.format({ async = true }) end, opts)
    key.map("n", "gwa", vim.lsp.buf.add_workspace_folder, opts)
    key.map("n", "gwr", vim.lsp.buf.remove_workspace_folder, opts)
    key.map("n", "gwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, event.buf)
    end
  end
})
