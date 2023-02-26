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

      lua-language-server
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
