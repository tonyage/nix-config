{ config, pkgs,... }:
with config;

let
  username = home.username;
in {
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND=1;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg = {
        enableBrowserpass = false;
        enableGnomeExtensions = true;
        enableTridactylNative = true;
      };
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
          "browser.newtabpage.pinned" = [
            { title = "github"; url = "https://github.com"; }
            { title = "gmail"; url = "https://mail.google.com"; }
            { title = "twitter"; url = "https://twitter.com"; }
          ];
        };
        search = {
          force = true;
          engines = {
            "NixOS Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icon/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "options"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icon/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };
          };
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          darkreader
          enhanced-github
          multi-account-containers
        ];
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
      name=${username}
      isrelative=1
      path=${username}
      default=1

      [general]
      StartWithLastProfle=1
      Version=2
    '';
  };
}
