{ pkgs, ... }: {
  home.stateVersion = "22.11";
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
  };
  programs.exa.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  home.packages = with pkgs; [ fd bottom ];

  imports = [ 
    ./shell/bat
    ./shell/git
    ./shell/wezterm
    ./shell/zellij
  ];
}
