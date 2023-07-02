{ colorscheme, config, pkgs, ... }: with colorscheme; {
  imports = [ ./services ../waybar ];
  home.packages = (with pkgs; [
    imv
    grim
    slurp
    waypipe
    swaylock
    wdisplays
    pavucontrol
    vulkan-tools
    wl-clipboard
    networkmanagerapplet
    sway-contrib.grimshot
  ]);

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    extraOptions = [ "--unsupported-gpu" ];
    config = rec {
      fonts = {
        names = [ "SF Pro" ];
        size = 10.0;
      };
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      modifier = "Mod4";
      terminal = "${pkgs.wezterm}/bin/wezterm";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      bars = [ ];
      assigns = {
        "1" = [ { app_id = "wezterm"; } ];
        "2" = [
          { class = "Chromium"; }
          { class = "Firefox"; }
        ];
        "3" = [ 
          { class = "Slack"; }
          { class = "Discord"; }
        ];
        "4" = [ { class = "Spotify"; } ];
      };
      colors = {
        background = "${normal.black}";
        focused = {
          background = "${normal.black}";
          border = "${normal.black}";
          childBorder = "${normal.black}";
          indicator = "${gradients.dark.black25}";
          text = "${normal.white}";
        };
        focusedInactive = {
          background = "${normal.black}";
          border = "${normal.black}";
          childBorder = "${normal.black}";
          indicator = "${normal.black}";
          text = "${gradients.dark.black25}";
        };
        unfocused = {
          background = "${gradients.dark.black10}";
          border = "${gradients.dark.black10}";
          childBorder = "${gradients.dark.black10}";
          indicator = "${gradients.dark.black10}";
          text = "${gradients.dark.black25}";
        };
        urgent = {
          background = "${normal.black}";
          border = "${normal.red}";
          childBorder = "${normal.red}";
          indicator = "${normal.red}";
          text = "${normal.white}";
        };
        placeholder = {
          background = "${gradients.dark.black20}";
          border = "${gradients.dark.black20}";
          childBorder = "${gradients.dark.black20}";
          indicator = "${gradients.dark.black20}";
          text = "${normal.white}";
        };
      };
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
      keybindings = let
        inherit terminal menu left down up right;
      in {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+q" = "kill";
        "${modifier}+b" = "split h";
        "${modifier}+v" = "split v";
        "${modifier}+i" = "exec firefox";
        "${modifier}+Shift+I" = "exec chromium";
        "${modifier}+r" = "mode resize";
        "${modifier}+s" = "scratchpad show";
        "${modifier}+Shift+S" = "move container to scratchpad";
        "${modifier}+t" = "floating toggle";

        "${modifier}+comma" = "layout stacking";
        "${modifier}+period" = "layout tabbed";
        "${modifier}+slash" = "layout toggle split";

        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+p" = "focus parent";
        "${modifier}+c" = "focus child";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";
        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        "${modifier}+Shift+left" = "move workspace to output left";
        "${modifier}+Shift+right" = "move workspace to output right";
        "${modifier}+Shift+Control+l" = "${pkgs.swaylock}/bin/swaylock -f -i \"${config.home.homeDirectory}/pics/wallpaper-dark-lock.png\"";

        "${modifier}+Control+left" = "move container to workspace prev, workspace next";
        "${modifier}+Control+right" = "move container to workspace next, workspace next";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";

        "${modifier}+Shift+P" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- ss-$(date +%Y%m%d-%H%M%S).png";
        "${modifier}+m" = "exec ${pkgs.mako}/bin/makoctl dismiss";

        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        
        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 10";
        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 10";
      };
      output = let
        lg-1 = "LG Electronics 27GN950 101NTFAC5283";
        dell-1 = "Dell Inc. Dell AW2721D #GTIYMxgwABpO";
        dell-2 = "Dell Inc. Dell AW2721D #GTIYMxgwAAda";
      in {
        "*".bg = ''"${config.home.homeDirectory}/pics/wallpaper-dark.jpg" "fill"'';
        "${lg-1}" = { pos = "0 0"; mode = "3840x2160@140Hz"; scale = "1.50"; };
        "${dell-1}" = { pos = "2560 0"; mode = "2560x1440@240Hz"; };
        "${dell-2}" = { pos = "5120 0"; mode = "2560x1440@240Hz"; };
      };
      modes = {
        resize = {
          Left = "resize shrink width";
          Down = "resize shrink height";
          Up = "resize grow height";
          Right = "resize grow width";
          Escape = "mode default";
          Return = "mode default";
        };
      };
      startup = [
        { command = "${pkgs.wezterm}/bin/wezterm"; }
        { command = "${pkgs.mako}/bin/mako"; always = true; }
        { command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"; always = true; }
        { command = "${pkgs.systemd}/bin/systemctl --user restart kanshi.service"; always = true; }
      ];
      window = {
        border = 0;
        hideEdgeBorders = "both";
        commands = [
          {
            command = "inhibit_idle fullscreen";
            criteria.app_id = "chromium";
          }
          {
            command = "inhibit_idle fullscreen";
            criteria.app_id = "org.wezfurlong.wezterm";
          }
          {
            command = "move to workspace 3";
            criteria.class = "Spotify";
          }
        ];
      };
      workspaceAutoBackAndForth = true;
      floating.border = 2;
      floating.criteria = [
        { app_id = "nm-*"; }
        { app_id = ".blue*"; }
      ];
    };
    #export WLR_RENDERER=vulkan
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATIONS="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export WLR_NO_HARDWARE_CURSORS=1
      export WLR_DRM_NO_MODIFIERS=1
      export XWAYLAND_NO_GLAMOUR=1
    '';
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
  };
  systemd.user.targets.sway-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
}
