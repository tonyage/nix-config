local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lspkind = require("ui.icons").lspkind
local constants = require("main.constants")
local key = require("main.mappings")

require("ui.themer").highlight("lazy")
local lazy_defaults = {
  defaults = { lazy = true },
  checker = {
    enabled = false,
    notify = true
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
    size = { width = 0.5, height = 0.5 },
    border = "double",
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
  "williamboman/mason.nvim",
  "rcarriga/nvim-notify",
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      local manager = require("neo-tree.sources.manager")
      local function close()
        manager.close_all()
      end
      local function show()
        manager.show("filesystem")
      end
      require("auto-session").setup({
        auto_session_suppress_dirs = { "~/", "~/Downloads", "~/git", "~/Code" },
        bypass_session_save_file_types = { "neo-tree", "terminal" },
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_use_git_branch = true,
        pre_save_cmds = { close() },
        pre_restore_cmds = { close() },
        post_restore_cmds = { show() },
        cwd_change_handling = {
          restore_upcoming_session = true,
          pre_cwd_changed_hook = close(),
          post_cwd_changed_hook = show()
        }
      })
      vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    keys = {
      { "|", "<cmd>Neotree reveal<CR>", desc = "NeoTree" }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- key.map("n", "|", ":Neotree reveal <CR>")
      require("neo-tree").setup(require("main.config.neotree"))
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false }
        })
      end, 100)
    end
  },

  {
    "nvchad/nvim-colorizer.lua",
    event = "BufEnter",
    opts = {
      filetypes = {
        "nix",
        lua = { names = false },
        css = { rgb_fn = true },
        "scss",
        "javascript",
        html = { names = false }
      },
    },
    config = function(_, opts)
      require("colorizer").setup(opts)
    end
  },

  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = {
      "zbirenbaum/copilot.lua"
    },
    config = function()
      require("copilot_cmp").setup()
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navic",
    },
    tag = "v0.1.4",
    init = function() require("lsp") end,
  },

  { "tpope/vim-fugitive", event = { "VeryLazy" } },
  { "windwp/nvim-autopairs", event = { "InsertEnter" }, config = true },
  { "numToStr/Comment.nvim", lazy = false, config = true },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.indent_blankline_char =  "▏"
    end,
    config = {
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
    config = require("main.config.gitsigns")
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
    opts = {
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
    },
    config = function(_, opts)
      vim.g.navic_silence = true
      require("nvim-navic").setup(opts)
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

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-context"
    },
    init = function() require("main.config.treesitter") end
  },
}, lazy_defaults)
