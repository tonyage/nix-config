{ pkgs, ... }: {
  home.packages = with pkgs; [
    tree-sitter
    nodejs
    gopls

    gcc13

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
    gitlint

    deadnix
    statix
    nil

    cmake-language-server
    cmake-format
    llvmPackages_15.llvm
    llvmPackages_15.clang-unwrapped

    ruff

    pyright

    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    yamllint
    yamlfmt
    vimPlugins.nvim-treesitter.withAllGrammars
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
