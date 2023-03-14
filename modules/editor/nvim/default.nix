{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];

    extraPackages = with pkgs; [
      gcc12
      tree-sitter
      nodejs
      python311

      buf
      buf-language-server

      nodePackages.bash-language-server
      shellcheck
      shfmt

      nodePackages.dockerfile-language-server-nodejs
      hadolint

      ltex-ls
      lua-language-server
      stylua

      kotlin-language-server
      ktlint

      gopls
      gitlint

      deadnix
      statix
      nil

      cmake-language-server
      cmake-format
      llvmPackages_15.llvm

      ruff

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
