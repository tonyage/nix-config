{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      copilot-vim

      alpha-nvim
      lazy-nvim
      indent-blankline-nvim
      nvim-colorizer-lua

      gitsigns-nvim
      vim-fugitive

      neo-tree-nvim
      nvim-tree-lua
      nvim-navic

      nvim-autopairs
      comment-nvim
      nvim-surround
      nvim-lspconfig
      todo-comments-nvim

      telescope-nvim
      telescope-fzf-native-nvim

      plenary-nvim
      popup-nvim
      project-nvim
      nvim-web-devicons

      nvim-cmp
      luasnip
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-buffer
      cmp-calc
      cmp-path

      nvim-dap
      nvim-dap-python
      nvim-dap-ui

      fidget-nvim
      null-ls-nvim
      rust-tools-nvim
      crates-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
    ];

    extraPackages = with pkgs; [
      gcc12

      nodePackages.bash-language-server
      shellcheck
      shfmt

      nodePackages.dockerfile-language-server-nodejs
      hadolint

      sumneko-lua-language-server
      luaformatter

      gitlint
      texlab

      deadnix
      statix
      nil

      cmake-language-server

      python3Packages.isort
      nodePackages.pyright
      black

      rust-analyzer
      rustfmt
      clippy

      nodePackages.yaml-language-server
      yamllint
    ];
  };

  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    "nvim/init.lua".source = ./init.lua;
  };
}
