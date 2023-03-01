{ config, pkgs, ... }:
with config;

let
  username = home.username;
in {
  home.packages = with pkgs; [ firefox-wayland ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND=1;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = { };
    };
    profiles = {
      "${username}" = {
        name = "${username}";
        
        settings = {
          "app.normandy.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "devtools.theme" = "dark";
          "general.smoothscroll" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "widget.content.allow-gtk-dark-theme" = true;
        };
        userChrome = ''
          @-moz-document
            url(chrome://browser/content/browser.xul),
            url(chrome://browser/content/browser.xhtml) {
            #tabbrowser-tab { z-index: 0 !important; } 
            #tabbbrowser-arrowscrollbox > spacer { z-index: -1 !important; }
            #mainPopupSet { z-index: 9999 !important; }

            @import uri(./ss/tabs-hide-if-only-one.css);
          }
        '';
        userContent = ''
          
        '';
      };
    };
  };
  home.file = {
    ".mozilla/firefox/profiles.ini".text = ''
      [Profile0]  
      Name=${username}
      IsRelative=1
      Path=${username}
      Default=1

      [General]
      StartWithLastProfle=1
      Version=2
    '';
  };
}
