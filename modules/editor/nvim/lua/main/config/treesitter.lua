require("ui.themer").highlight("treesitter")


parser_install_dir = vim.fn.stdpath("data") .. "/treesitter"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

local config = {
  parser_install_dir = parser_install_dir,
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "cmake",
    "c_sharp",
    "comment",
    "dart",
    "dockerfile",
    "go",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "help",
    "html",
    "java",
    "json",
    "javascript",
    "kotlin",
    "latex",
    "lua",
    "markdown",
    "nix",
    "proto",
    "python",
    "regex",
    "rust",
    "scss",
    "swift",
    "toml",
    "typescript",
    "vim",
    "yaml"
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-Space>",
      node_incremental = "<C-Space>",
      scope_incremental = "<nop>",
      node_decremental = "<BS>"
    }
  },
  auto_install = true,
  indent = { enable = true },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grn"
      }
    }
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = { ["<leader>sn"] = "@parameter.inner" },
      swap_previous = { ["<leader>sp"] = "@parameter.inner" },
    },
  },
}

require("nvim-treesitter.configs").setup(config)

