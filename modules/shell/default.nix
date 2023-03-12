{ pkgs, ... }: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
  };
  programs.exa.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  imports = [ ./bat ./bash ./git ./zellij ./zsh ];
  home.packages = with pkgs; [ fd htop ];
}
