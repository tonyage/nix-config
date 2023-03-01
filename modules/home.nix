{ config, inputs, pkgs, ... }: with config; {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    zip
    noto-fonts
    noto-fonts-emoji
    (nerdfonts.override { 
      fonts = [ "JetBrainsMono" ];
    })
  ];
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
  xdg.userDirs = {
    enable = true;
    desktop = "${home.homeDirectory}/";
    music = "${home.homeDirectory}/";
    templates = "${home.homeDirectory}/";
    videos = "${home.homeDirectory}/";

    documents = "${home.homeDirectory}/git";
    download = "${home.homeDirectory}/dl";
    publicShare = "${home.homeDirectory}/pub";
    pictures = "${home.homeDirectory}/pics";
  };
}
