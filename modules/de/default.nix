{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    gimp-with-plugins
    pciutils
    bridge-utils
    unzip
    looking-glass-client
  ];
}
