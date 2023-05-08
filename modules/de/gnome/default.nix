{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-themes-extra
    gnomeExtensions.pop-shell
    gnomeExtensions.bluetooth-quick-connect
    gnome-extension-manager
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true; 
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      monospace-font-name = "JetBrainsMono Nerd Font";
    };
    "org/gnome/shell" = {
      enabled-extensions = with pkgs; [
        gnomeExtensions.bluetooth-quick-connect.extensionUuid
      ];
    };
  };
}
