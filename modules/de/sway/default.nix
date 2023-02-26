{ colorscheme, pkgs, ... }: with colorscheme; {
  home.packages = (with pkgs; [
    grim
    slurp
    waypipe
    swaylock
    pavucontrol
    wl-clipboard
    sway-contrib.grimshot
  ]);

  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    config = rec {
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/footclient";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      bars = [{
        colors = {
          background = "${normal.black}";
          statusline = "${normal.black}";
        };
        fonts = {
          name = [ "Noto Sans" "" ];
          size = 15.0;
        };
        position = "top";
      }];
      assigns = {
        "1" = [ { app_id = "foot"; } ];
        "2" = [ { class = "Chromium"; } ];
        "4" = [ 
          { app_id = "Slack"; }
          { app_id = "Discord"; }
        ];
      };
      colors = {
        focused = {
          background = "${normal.black}";
          border = "${normal.black}";
          childBorder = "${normal.black}";
          indicator = "${normal.black}";
          text = "${normal.white}";
        };
        focusedInactive = {
          background = "${normal.black}";
          border = "${normal.black}";
          childBorder = "${normal.black}";
          indicator = "${normal.black}";
          text = "${normal.white}";
        };
        unfocused = {
          background = "${gradients.dark.black10}";
          border = "${gradients.dark.black10}";
          childBorder = "${gradients.dark.black10}";
          indicator = "${gradients.dark.black10}";
          text = "${normal.white}";
        };
        urgent = {
          background = "${normal.black}";
          border = "${normal.red}";
          childBorder = "${normal.red}";
          indicator = "${normal.red}";
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
      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+q" = "kill";
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+b" = "split h";
        "${modifier}+v" = "split v";

        "${modifier}+comma" = "layout stacking";
        "${modifier}+period" = "layout tabbed";
        "${modifier}+slash" = "layout toggle split";

        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+p" = "focus parent";
        "${modifier}+c" = "focus child";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        
        "${modifier}+r" = "mode resize";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";
        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        "${modifier}+apostrophe" = "move workspace to output right";
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
      output = {
        eDP-1 = { scale = "1.25"; };
      };
      modes = {
        resize = {
          Left = "resize shrink width";
          Down = "resize shrink height";
          Up = "resize grow height";
          Right = "resize grow width";
        };
      };
      startup = [
        { command = "foot"; }
      ];
      window.commands = [
        {
          command = "inhibit_idle fullscreen";
          criteria.app_id = "chromium";
        }
        {
          command = "move to workspace 3";
          critieria.class = "Spotify";
        }
      ];
      workspaceAutoBackAndForth = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
  };
  systemd.user.services.swayidle.Service.Slice = "session.slice";
  systemd.user.targets.sway-session.Unit.Wants = [ "xdg-desktop-autostart-target" ];
}
