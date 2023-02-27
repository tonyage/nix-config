{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];

    extraPackages = with pkgs; [
      gcc12
      tree-sitter
      nodejs

      nodePackages.bash-language-server
      shellcheck
      shfmt

      nodePackages.dockerfile-language-server-nodejs
      hadolint

      ltex-ls
      lua-language-server
      luaformatter

      kotlin-language-server

      gopls
      gitlint

      deadnix
      statix
      nil

      cmake-language-server
      llvmPackages_15.llvm

      python3Packages.isort
      nodePackages.pyright
      black

      rust-analyzer
      rustfmt
      clippy

      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      yamllint
      yamlfmt
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
