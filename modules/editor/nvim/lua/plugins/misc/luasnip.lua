local config = {
  history = true,
  updateevents = "TextChanged,TextChangedI"
}

require("luasnip").config.set_config(config)
require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.luasnippets_path or "" })
require("luasnip.loaders.from_vscode").lazy_load()

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if
      require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})
