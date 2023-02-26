{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
  };
  programs.exa.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  imports = [ ./alacritty ./bat ./bash ./git ./foot ./ssh ./zellij ./zsh ];
}
