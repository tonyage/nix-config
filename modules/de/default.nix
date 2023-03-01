{ pkgs, ... }: {
  imports = [ ./sway ];
  xdg.configFile."gtk-3.0/settings.ini".text = "${(builtins.readFile ./gtk-settings.ini)}";
  xdg.configFile."gtk-4.0/settings.ini".text = "${(builtins.readFile ./gtk-settings.ini)}";
}
