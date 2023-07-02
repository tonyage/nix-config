{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    gimp-with-plugins
    pciutils
    bridge-utils
    unzip
  ];
  home.keyboard.options = [ "ctrl:nocaps" ];
  xdg.configFile."gtk-2.0/settings.ini".text = "${(builtins.readFile ./gtk-settings.ini)}";
  xdg.configFile."gtk-2.0/gtk.css".text = "${(builtins.readFile ./gtk.css)}";

  xdg.configFile."gtk-3.0/settings.ini".text = "${(builtins.readFile ./gtk-settings.ini)}";
  xdg.configFile."gtk-3.0/gtk.css".text = "${(builtins.readFile ./gtk.css)}";

  xdg.configFile."gtk-4.0/settings.ini".text = "${(builtins.readFile ./gtk-settings.ini)}";
  xdg.configFile."gtk-4.0/gtk.css".text = "${(builtins.readFile ./gtk.css)}";
}
