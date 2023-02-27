{
  programs.bash = {
    enable = false;
    shellAliases = import ../aliases.nix;
  };
}
