{ self, pkgs, ... }: {

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    cantarell-fonts
    noto-fonts
    material-icons
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
}
