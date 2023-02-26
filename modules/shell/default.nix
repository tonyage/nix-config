{ pkgs, ... }:
{
  programs.exa.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  imports = [ ./alacritty ./bat ./git ./foot ./ssh ./zellij ./zsh ];

  home.packages = with pkgs; [
    ripgrep
    fd
    coreutils
  ];
}
