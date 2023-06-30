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
            { title = "reddit"; url = "https://reddit.com"; }
            { title = "amazon"; url = "https://amazon.com"; }
            { title = "wikipedia"; url = "https://wikipedia.org"; }
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
          multi-account-containers
        ];
        userChrome = ''
          :root {
            --tab-border-radius: 0px !important;
            --tab-block-margin: 0px !important;
          }
          :root[uidensity="compact"] {
            --tab-min-height: 18px !important;
            --tab-border-radius: 0px !important;
            --tab-block-margin: 0px !important;
          }
          #tabbrowser-tabs:not([secondarytext-unsupported]) .tab-label-container {
            height: initial !important;
          }
          .titlebar-buttonbox-container {
            display: none;
          }
        '';
        userContent = ''
          @-moz-document
            url(chrome://browser/content/browser.xul),
            url(chrome://browser/content/browser.xhtml) {
            #tabbrowser-tab { z-index: 0 !important; } 
            #tabbbrowser-arrowscrollbox > spacer { z-index: -1 !important; }
            #mainPopupSet { z-index: 9999 !important; }

            @import uri(./ss/tabs-hide-if-only-one.css);
          }
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
