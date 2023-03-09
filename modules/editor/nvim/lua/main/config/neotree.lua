require("ui.themer").highlight("neotree")
local keybind = require("main.mappings")
keybind.map("n", "<leader>e", ":Neotree toggle show filesystem left<CR>")
keybind.map("n", "<leader>r", ":Neotree float reveal_file<cfile> reveal_force_cwd<CR>")
keybind.map("n", "<leader>ns", ":Neotree float git_status<CR>")
return {
  filesystem = {
    visible = true,
    hijack_netrw_behavior = "open_default",
    always_show = {
      ".github/",
      ".envrc",
      ".env",
      ".editorconfig",
      "build"
    },
  },
  default_component_configs = {
    container = {
      right_padding = 1
    }
  },
  source_selector = {
    winbar = true,
    tabs_layout = "equal",
    show_separator_on_edge = false,
  },
}
