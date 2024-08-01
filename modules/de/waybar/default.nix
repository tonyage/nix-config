{ colorscheme, pkgs, ... }: with colorscheme; {
  home.packages = with pkgs; [ nerdfonts ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      height = 24;
      layer = "top";
      position = "top";
      modules-left = [ "custom/os-icon" "sway/workspaces" "sway/mode" "sway/scratchpad" "sway/window" ];
      modules-center = [ ];
      modules-right = [
        "idle_inhibitor"
        "cpu"
        #"memory"
        #"temperature"
        #"battery"
        "pulseaudio"
        "tray"
        #"network"
        "clock"
      ];
      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{icon}";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "<span color=\"${normal.green}\"></span>";
          "5" = "";
          "urgent" = "";
          "focused" = "";
          "default" = "";
        };
        persistent_workspaces = {
          "1" = [ ];
          "2" = [ "eDP-1" "DP-1" "DP-3" ];
          "3" = [ "eDP-1" ];
          "4" = [ "eDP-1" ];
        };
      };
      "custom/os-icon" = { format = ""; };
      "sway/mode" = {
        format = " {}";
      };
      "sway/scratchpad" = {
        format = "{icon} {count}";
        show-empty = false;
        format-icons = [ "" " " ];
        tooltip = true;
        tooltip-format = "{app}: {title}";
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      tray = {
        icon-size = 20;
        spacing = 10;
      };
      clock = {
        timezone = "America/Chicago";
        format = "{:%b %e  %I:%M %p}";
        tooltip-format = "<big>{ =%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        tooltip = true;
      };
      cpu = {
        format = " {max_frequency}Ghz │ <span color=\"${gradients.dark.black20}\">{usage}%</span>";
        on-click = "footclient htop --sort-key PERCENT_CPU";
        min-length = 15;
        tooltip = false;
      };
      memory = {
        format = " {}%";
      };
      temperature = {
        thermal-zone = 2;
        interval = 4;
        hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
        critical-threshold = 80;
        format-critical = "{icon} {temperatureC}°C";
        format = "{icon}  {temperatureC}°C";
        format-icons = [ "" "" "" ];
      };
      battery = {
        states = {
          good = 95;
          warning = 50;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-alt = "{icon} {time}";
        format-good = "";
        format-full = "";
        format-icons = [ "" "" "" "" "" ];
      };
      network = {
        interface = "wlp*";
        format-wifi = "  {essid} {signalStrength}%";
        format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "\ue648";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        family = "ipv4";
        tooltip-format = "{ifname} via {gwaddr} ";
        tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\n {bandwidthUpBits}  {bandwidthDownBits}";
        tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n {bandwidthUpBits}  {bandwidthDownBits}";
      };
      pulseaudio = {
        scroll-step = 1;
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = " {volume}%";
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
        on-click = "pavucontrol";
      };
    }];
    style = ''
      @keyframes blink {
        to {
          background-color: ${normal.white};
          color: ${gradients.dark.black};
        }
      }

      * {
        border: none;
        min-height: 0px;
      }

      #waybar {
        font-family: SF Pro, Font Awesome;
        font-size: 12px;  
        margin: 0px;
        padding: 0px;
      }
      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }
      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px ${normal.white};
      }

      #workspaces,
      #custom-os-icon {
        font-size: 12px;
        padding: 0px 5px 0px 5px;
        color: ${normal.white};
      }

      #custom-os-icon {
        font-size: 12px;
        margin-right: 10px;
        margin-left: 10px;
        background: transparent;
      }

      #clock,
      #window {
        font-size: 12px; 
      }
      window#waybar {
        background-color: ${gradients.dark.black};
        color: ${normal.white};
        transition-property: background-color;
        transition-duration: .5s;
      }
      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        padding: 0px 5px;
        background-color: transparent;
        color: ${normal.white};
      }
      #workspaces button.focused {
        background-color: ${gradients.dark.black00};
        box-shadow: inset 0 -3px ${normal.blue};
      }
      #workspaces button.urgent {
        box-shadow: inset 0 -3px ${error};
      }
      
      #mode {
        background-color: ${normal.red};
        color: ${normal.black};
      }
      
      /* Each module that should blink */
      #memory,
      #temperature,
      #battery {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }      

      /* Each critical module */
      #network.disconnected,
      #memory.critical,
      #cpu.critical,
      #temperature.critical,
      #battery.critical {
        background: ${error};
        color: ${normal.black};
      }

      /* Each critical that should blink */
      #mode,
      #memory.critical,
      #temperature.critical,
      #battery.critical.discharging {
        background-color: ${error};
        color: ${normal.black};
        animation-duration: 0.5s;
      } 

      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #mode,
      #idle_inhibitor {
        font-size: 12px;
        border-radius: 5px;
        margin: 5px 5px 5px 5px;
        padding: 0px 5px 0px 5px;
        color: ${normal.black};
      }
      
      #clock {
        font-size: 12px;
        font-weight: bold;
        background: ${gradients.dark.black};
        color: ${normal.white};
        padding: 0px 5px 0px 5px;
        margin-left: 5px;
        margin-right: 10px;
      }
      
      #battery {
        background-color: ${normal.green};
        color: ${normal.black};
      }

      #battery.charging,
      #battery.plugged {
        color: ${normal.black};
        background-color: ${normal.yellow};
      }
      
      #cpu {
        background: #2ecc71;
        color: ${normal.black};
      }
      
      #memory {
        background: ${normal.magenta};
      }
      
      #network {
        background: ${normal.blue};
      }
      
      #pulseaudio {
        background: ${normal.orange};
        color: ${gradients.dark.black};
      }
      
      #pulseaudio.muted {
        background: ${normal.red};
        color: ${normal.black};
      }
      
      #wireplumber {
        color: ${gradients.dark.black};
      }
      
      #wireplumber.muted {
        background-color: ${error};
      }
      
      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 150px;
      }
      
      #custom-media.custom-spotify {
        background-color: #66cc99;
      }
      
      #temperature {
        background-color: ${normal.orange};
      }
      
      #idle_inhibitor {
        color: ${gradients.light.white90};
        font-weight: bold;
      }

      #scratchpad {
        font-size: 10px;
        margin-left: 5px;
        margin-right: 10px;
        background: transparent;
        color: ${normal.orange};
      }
      #scratchpad.empty {
        background: transparent;
      }    

      #tray {
        background: transparent;
        border-radius: 5px;
        margin: 2px 5px 2px 5px;
        padding: 0px 5px 0px 5px;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }
    '';
  };
}
