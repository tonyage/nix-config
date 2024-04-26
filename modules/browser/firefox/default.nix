{ colorscheme, config, pkgs, ... }:

with config;
with colorscheme;

let
  username = home.username;
in
{
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
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
          firefox-translations
        ];
        userChrome = ''
          :root {
            --tab-border-radius: 0px !important;
            --tab-block-margin: 0px !important;
          }
          :root[uidensity="compact"] {
            --tab-min-height: 26px !important;
            --tab-border-radius: 0px !important;
            --tab-block-margin: 10px !important;
          }
          #tabbrowser-tabs:not([secondarytext-unsupported]) .tab-label-container {
            height: initial !important;
          }
          #tabbrowser-tabs .tab-background {
            border-bottom: solid 0px var(--identity-icon-color, ${normal.white}) !important;
            background: ${normal.black} !important;
          }
          #tabbrowser-tabs .tab-background[selected="true"] {
            border-top: solid 1px var(--identity-icon-color, ${normal.blue}) !important;
            background: ${gradients.dark.black05} !important;
          }
          .titlebar-buttonbox-container {
            display: none;
          }
          #tabbrowser-tabs .tabbrowser-tab:not([selected="true"]) .tab-background{
            background: ${gradients.dark.black} !important; 
          }
          #TabsToolbar {
            background: ${gradients.dark.black} !important;
          }
          #sidebar-header { 
            -moz-transition: all .2s ease-out .2s !important;
            padding: 4px !important;
            background-color: ${gradients.dark.black15};
            border: none !important;
          }
          #tabbar tab-item tab-item-substance:not(:hover) tab-closebox {
            display: none;
          }
          #sidebar-box *, #bookmarksPanel *, #history-panel * {
            font-size: 10pt !important;
          }
          #sidebar-header:not(:hover) #sidebar-close {
            opacity: 0px !important;
          }
          .sidebar-splitter {
            width: 1px !important;
            border: none !important;
            background-color: ${gradients.dark.black05} !important;
          } 
          #nav-bar {
            background-color: ${gradients.dark.black05} !important;
          }
          #urlbar-background {
            background-color: ${normal.black} !important;
          }
          #urlbar-input-container {
            background: ${normal.black} !important;
          }
          findbar {
            background-color: ${gradients.dark.black10} !important;
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
          @-moz-document url-prefix("about:") {
            :root {
              --primary-background: ${normal.black} !important;
              --secondary-background: ${gradients.dark.black05} !important;
              --in-content-page-background: ${normal.black} !important;
            }
          }
          @-moz-document url-prefix("about:preferences") {
            .main-content {
              background-color: var(--primary-background) !important;
            }
          }
          @-moz-document url-prefix("about:addons") {
            #sidebar {
              background-color: var(--secondary-background) !important;
            }
          }
          @-moz-document regexp("moz-extension://.+/resources/group-tab.html.*") {
            :root {
              background: ${normal.black} !important;
            }
          }
          tab-item {
            --tab-size: 32px !important;
          }
          tab-item.unread .label-content {
            font-style: italic !important;
          }
          tab-favicon::before {
            background-image: none;
          }
          :root[color-scheme="system-color"][data-user-agent*="Linux"]
            tab-item:not(.active):not(.bundled-active):not(.highlighted),
          :root[color-scheme="system-color"][data-user-agent*="Linux"]
            .after-tabs button,
          :root[color-scheme="system-color"][data-user-agent*="Linux"]
            .after-tabs [role="button"],
          :root[color-scheme="system-color"][data-user-agent*="Linux"]
            #subpanel-selector-anchor,
          :root[color-scheme="system-color"][data-user-agent*="Linux"]
            #background {
            background-color: ${gradients.dark.black05} !important;
          }
          tab-item:not(.pinned) tab-item-substance {
            padding-left: 10px !important;
          }
          tab-item tab-item-substance {
            height: var(--tab-size);
          }
          tab-item.active .background {
            background-color: ${gradients.dark.black15} !important;
            border-left: none !important;
          }
          #tabbar tab-item tab-item-substance:not(:hover) tab-closebox {
            display: none;
          }
          .newtab-button-box {
            margin-top: 10px !important;
            opacity: 0.5 !important;
          }
          tab-item:not(collapsed) tab-twisty {
            background-color: inherit !important;
          }
          tab-item tab-counter {
            margin-right: 2px !important;
          }
          :root.group-tab li {
            position: relative;
          }
          :root.group-tab img,
          :root.group-tab .label {
            z-index: 100;
          }
          tab-item:not(.pinned) .contextual-identity-marker {
            position: absolute !important;
            width: 1px !important;
            height: 80% !important;
            opacity: 0.2 !important;
          }
          tab-label {
            z-index: 1000;
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
