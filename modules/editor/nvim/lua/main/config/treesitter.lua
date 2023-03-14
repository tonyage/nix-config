require("ui.themer").highlight("treesitter")

local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

local config = {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "diff",
    "gitattributes",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "java",
    "javascript",
    "json",
    "json5",
    "kdl",
    "kotlin",
    "llvm",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "ninja",
    "proto",
    "python",
    "regex",
    "rust",
    "scss",
    "starlark",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml"
  },
  parser_install_dir = parser_install_dir,
  auto_install = true,
  indent = { enable = true },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = { smart_rename = "grn" },
    },
    navigation = {
      enable = true,
      goto_definition_lsp_fallback = "gD"
    },
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

