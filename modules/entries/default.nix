{ pkgs, ... }: {
  xdg.desktopEntries = {
    "org.wezfurlong.wezterm" = {
      name = "WezTerm";
      comment = "Wez's Terminal Emulator";
      icon = "${pkgs.wezterm}/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png";
      exec = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel wezterm";
      type = "Application";
      categories = [ "System" "TerminalEmulator" "Utility" ];
      terminal = false;
    };
    #firefox = {
    #  name = "Firefox";
    #  exec = "${pkgs.firefox}/bin/firefox %u";
    #  #icon = "${pkgs.firefox}/share/icons/hicolor/128x128/apps/firefox.png";
    #  terminal = false;
    #  categories = [ "Application" "Network" "WebBrowser" ];
    #  mimeType = [ "text/html" "text/xml" ];
    #};
  };
}
