require("ui.themer").highlight("lsp")
local key = require("main.mappings")
local windows = require("ui.windows")
local symbols = require("ui.icons").lsp
local M = {}

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

for _, symbol in pairs(symbols) do
  lspSymbol(symbol.name, symbol.icon)
end

vim.diagnostic.config {
  virtual_text = { prefix = "", source = "always" },
  signs = false,
  update_in_insert = true,
}

M.handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, windows.hover),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, windows.hover),
}

key.map("n", "gof", vim.diagnostic.open_float, { noremap = true, silent = true })
key.map("n", "gn", vim.diagnostic.goto_next, { noremap = true, silent = true })
key.map("n", "gb", vim.diagnostic.goto_prev, { noremap = true, silent = true })
key.map("n", "gq", vim.diagnostic.setloclist, { noremap = true, silent = true })

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M

