require("ui.themer").highlight("neotree")
local keybind = require("main.mappings")
keybind.map("n", "<leader>e", ":Neotree toggle<CR>")
keybind.map("n", "<leader>r", ":Neotree float reveal_file<cfile> reveal_force_cwd<CR>")
keybind.map("n", "<leader>ns", ":Neotree float git_status<CR>")
return {
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = true,
      always_show = {
        ".github/",
        ".envrc",
        ".env",
        ".editorconfig",
        "build/",
        ".gitignore"
      },
    },
  },
  use_libuv_file_watcher = true,
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
