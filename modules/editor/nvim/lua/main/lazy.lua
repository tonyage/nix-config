local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lspkind = require("ui.icons")["lspkind"]

require("ui.themer").highlight("lazy")
local lazy_defaults = {
  defaults = { lazy = true },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = true
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin", "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
  ui = {
    size = { width = 0.5, height = 0.4 },
    border = "single",
  },
}

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  "L3MON4D3/LuaSnip",
  "rcarriga/nvim-notify",
  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001
  },
  {
    'bennypowers/splitjoin.nvim',
    lazy = "BufEnter",
    keys = {
      {
        "gj",
        function()
          require("splitjoin").join()
        end,
        desc = "Join the object under the cursor"
      },
      {
        "g,",
        function()
          require("splitjoin").split()
        end,
        desc = "Split the object under the cursor"
      },
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    keys = { "|" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = require("main.config.neotree"),
  },

  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    init = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end
  },

  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = "zbirenbaum/copilot.lua",
    config = true
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "InsertEnter",
    dependencies = "nvim-lua/plenary.nvim",
    init = function()
      require("null-ls").setup(require("main.config.null"))
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navic",
    },
    init = function() require("lsp") end,
  },

  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "mbbill/undotree", event = "InsertEnter" },
  { "ThePrimeagen/harpoon", event = "InsertEnter", config = true },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "numToStr/Comment.nvim", lazy = false, config = true },

  {
    "nvchad/nvim-colorizer.lua",
    event = "BufEnter",
    opts = {
      filetypes = {
        "nix",
        lua = { names = false },
        css = { rgb_fn = true },
        html = { names = false },
        "scss",
        "javascript"
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "VeryLazy" },
    init = function()
      vim.g.indent_blankline_char =  "▏"
    end,
    opts = {
      show_end_of_line = true,
      show_current_context = true,
      show_current_context_start = true,
      use_treesitter_scope = true,
      show_first_indent_level = false,
      space_char_blankline = " "
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufEnter" },
    opts = require("main.config.gitsigns")
  },

  {
    "kylechui/nvim-surround",
    lazy = false,
    config = true
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("main.config.telescope")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("main.config.cmp")
    end,
  },

  {
    "SmiteshP/nvim-navic",
    config = function()
      vim.g.navic_silence = true
      require("nvim-navic").setup({
        icons = {
          File          = " ",
          Module        = lspkind["Module"],
          Namespace     = " ",
          Package       = " ",
          Class         = lspkind["Class"],
          Method        = " ",
          Property      = "練",
          Field         = " ",
          Constructor   = " ",
          Enum          = lspkind["Enum"],
          Interface     = lspkind["Interface"],
          Function      = " ",
          Variable      = " ",
          Constant      = " ",
          String        = " ",
          Number        = " ",
          Boolean       = "◩ ",
          Array         = " ",
          Object        = " ",
          Key           = " ",
          Null          = "ﳠ ",
          Struct        = lspkind["Struct"],
          Event         = " ",
          Operator      = " ",
          TypeParameter = " ",
        },
        highlight = true,
        separator = " " .. require("ui.icons").winbar["separator"]["light"]["right"] .. " ",
      })
    end,
  },

  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("ui.themer").highlight("devicons")
      require("nvim-web-devicons").setup({ override = require("ui.icons").devicons })
    end,
  },

  { "nvim-treesitter/playground" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    config = function()
      require("main.config.treesitter")
    end
  },
  { "nvim-treesitter/nvim-treesitter-context", event = { "BufReadPre" }, config = true },
}, lazy_defaults)

