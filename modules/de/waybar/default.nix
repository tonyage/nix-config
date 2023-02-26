{ colorscheme, ... }: with colorscheme; {
  programs.waybar = {
    enable = true;
    layer = "top";
    position = "bottom";
    height = 30;
    width = 1280;
    spacing = 4;
    modules-left = [ "custom/launcher" "sway/workspaces" "sway/mode" "sway/scratchpad" ];
    modules-center = [ "sway/window" ];
    modules-right = [
      "mpd"
      "idle_inhibitor"
      "pulseaudio"
      "network"
      "cpu"
      "memory"
      "temperature"
      "backlight"
      "keyboard-state"
      "sway/language"
      "battery"
      "battery#bat2"
      "clock"
      "tray"
    ];
    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{name} = {icon}";
      format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "urgent" = "";
          "focused" = "";
          "default" = "";
      };
    };
    "custom/launcher" = { format = ""; };
    "keyboard-state" = {
        numlock = true;
        capslock = true;
        format = "{name} {icon}";
        format-icons = {
          locked = "";
          unlocked = "";
        };
    };
    "sway/mode" = {
      format = "<span style=\"italic\">{}</span>";
    };
    "sway/scratchpad" = {
      format = "{icon} {count}";
      show-empty = false;
      format-icons = [ "" "" ];
      tooltip = true;
      tooltip-format = "{app} = {title}";
    };
    "mpd" = {
      format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime =%M =%S}/{totalTime =%M =%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
      format-disconnected = "Disconnected ";
      format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
      unknown-tag = "N/A";
      interval = 2;
      consume-icons = {
        "on" = " ";
      };
      random-icons = {
        off = "<span color=\"${base0F}\"></span> ";
        on = " ";
      };
      repeat-icons = {
        "on" = " ";
      };
      single-icons = {
        "on" = "1 ";
      };
      state-icons = {
        "paused" = "";
        "playing" = "";
      };
      tooltip-format = "MPD (connected)";
      tooltip-format-disconnected = "MPD (disconnected)";
    };
    "idle_inhibitor" = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
    "tray" = {
      icon-size = 21;
      spacing = 10;
    };
    "clock" = {
      timezone = "America/Chicago";
      tooltip-format = "<big>{ =%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "{:%b %a  %r %p}";
    };
    "cpu" = {
      format = "{usage}% ";
      tooltip = false;
    };
    "memory" = {
      format = "{}% ";
    };
    "temperature" = {
      thermal-zone = 2;
      hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
      critical-threshold = 80;
      format-critical = "{temperatureC}°C {icon}";
      format = "{temperatureC}°C {icon}";
      format-icons = ["" "" ""];
    };
    "backlight" = {
        device = "acpi_video1";
        format = "{percent}% {icon}";
        format-icons = [ "" "" "" "" "" "" "" "" "" ];
    };
    "battery" = {
      states = {
        good = 95;
        warning = 50;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {icon}";
      format-good = "";
      format-full = "";
      format-icons = [ "" "" "" "" "" ];
    };
    "network" = {
      interface = "wlp2*";
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname} = {ipaddr}/{cidr}";
    };
    "pulseaudio" = {
      scroll-step = 1;
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "" "" "" ];
      };
      "on-click" = "pavucontrol";
    };
  };
  xdg.configFile."waybar/config".text = ''
    * {
      font-family: Cantarell, FontAwesome;
      font-size: 15px;
      border-radius 3px;
    }
    window#waybar {
      background-color: ${black00};
      border-bottom: 3px solid ${blue};
      color: ${white};
      transition-property: background-color;
      transition-duration: .5s;
    }
    window#waybar.hidden {
      opacity: 0.2;
    }
    
    window#waybar.termite {
      background-color: ${base01};
    }
    
    window#waybar.chromium {
        background-color: ${black00};
        border: none;
    }
    
    button {
      /* Use box-shadow instead of border so the text isn't offset */
      box-shadow: inset 0 -3px transparent;
      /* Avoid rounded borders under each button name */
      border: none;
      border-radius: 0;
    }
    
    button:hover {
      background: inherit;
      box-shadow: inset 0 -3px ${white};
    }
    
    #workspaces button {
      padding: 0 5px;
      background-color: transparent;
      color: ${white};
    }
    
    #workspaces button:hover {
      background: rgba(0, 0, 0, 0.2);
    }
    
    #workspaces button.focused {
      background-color: #64727D;
      box-shadow: inset 0 -3px ${white};
    }
    
    #workspaces button.urgent {
      background-color: ${base0F};
    }
    
    #mode {
      background-color: #64727D;
      border-bottom: 3px solid ${white};
    }
    
    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #wireplumber,
    #custom-media,
    #tray,
    #mode,
    #idle_inhibitor,
    #scratchpad,
    #mpd {
      padding: 0 10px;
      color: ${white};
    }
    
    #window,
    #workspaces {
      margin: 0 4px;
    }
    
    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }
    
    .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
    }
    
    #clock {
      background-color: #64727D;
    }
    
    #battery {
      background-color: ${white};
      color: ${gradients.black};
    }
    
    #battery.charging, #battery.plugged {
      color: ${white};
      background-color: #26A65B;
    }
    
    @keyframes blink {
      to {
        background-color: ${white};
        color: ${gradients.black};
      }
    }
    
    #battery.critical:not(.charging) {
      background-color: ${base0F};
      color: ${white};
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }
    
    label:focus {
      background-color: ${gradients.black};
    }
    
    #cpu {
      background-color: #2ecc71;
      color: ${gradients.black};
    }
    
    #memory {
      background-color: #9b59b6;
    }
    
    #disk {
      background-color: #964B00;
    }
    
    #backlight {
      background-color: #90b1b1;
    }
    
    #network {
      background-color: #2980b9;
    }
    
    #network.disconnected {
      background-color: ${base0F};
    }
    
    #pulseaudio {
      background-color: #f1c40f;
      color: ${gradients.black};
    }
    
    #pulseaudio.muted {
      background-color: #90b1b1;
      color: #2a5c45;
    }
    
    #wireplumber {
      background-color: #fff0f5;
      color: ${gradients.black};
    }
    
    #wireplumber.muted {
      background-color: ${base0F};
    }
    
    #custom-media {
      background-color: #66cc99;
      color: #2a5c45;
      min-width: 100px;
    }
    
    #custom-media.custom-spotify {
      background-color: #66cc99;
    }
    
    #custom-media.custom-vlc {
      background-color: $orange;
    }
    
    #temperature {
      background-color: #orange;
    }
    
    #temperature.critical {
      background-color: #eb4d4b;
    }
    
    #tray {
      background-color: #2980b9;
    }
    
    #tray > .passive {
      -gtk-icon-effect: dim;
    }
    
    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #eb4d4b;
    }
    
    #idle_inhibitor {
      background-color: #2d3436;
    }
    
    #idle_inhibitor.activated {
      background-color: #ecf0f1;
      color: #2d3436;
    }
    
    #mpd {
      background-color: #66cc99;
      color: #2a5c45;
    }
    
    #mpd.disconnected {
      background-color: ${base0F};
    }
    
    #mpd.stopped {
      background-color: #90b1b1;
    }
    
    #mpd.paused {
      background-color: #51a37a;
    }
    
    #language {
      background: #00b093;
      color: #740864;
      padding: 0 5px;
      margin: 0 5px;
      min-width: 16px;
    }
    
    #keyboard-state {
      background: #97e1ad;
      color: ${gradients.black};
      padding: 0px 0px;
      margin: 0px 5px;
      min-width: 16px;
    }
    
    #keyboard-state > label {
      padding: 0px 5px;
    }
    
    #keyboard-state > label.locked {
      background: ${black};
    }
    
    #scratchpad {
      background: rgba(0, 0, 0, 0.2);
    }
    
    #scratchpad.empty {
    	background-color: transparent;
    }    
  '';
}
