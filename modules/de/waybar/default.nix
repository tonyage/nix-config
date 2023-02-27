{ colorscheme, pkgs, ... }: with colorscheme; {
  home.packages = with pkgs; [ nerdfonts ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      height = 30;
      layer = "top";
      position = "top";
      modules-left = [ "custom/os-icon" "sway/workspaces" "sway/mode" "sway/scratchpad" "sway/window" ];
      modules-center = [ ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "bluetooth"
        "battery"
        "backlight"
        "idle_inhibitor"
        "tray"
        "clock"
      ];
      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{icon}";
        format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
        };
        persistent_workspaces = {
          "1" = [];
          "2" = [ "eDP-1" "DP-2" ];
          "3" = [ "eDP-1" ];
          "4" = [ "eDP-1" ];
        };
      };
      "custom/os-icon" = { format = ""; };
      bluetooth = {
        interval = 30; 
        format = "{icon}";
        format-icons = {
          enabled = "";
          disabled = "";
        };
      };
      "sway/mode" = {
        format = " {}";
      };
      "sway/scratchpad" = {
        format = "{icon} {count}";
        show-empty = false;
        format-icons = [ "" "" ];
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
        icon-size = 24;
        spacing = 10;
      };
      clock = {
        timezone = "America/Chicago";
        format = "{:%b %e  %I:%M %p}";
        tooltip-format = "<big>{ =%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      cpu = {
        format = " {max_frequency}Ghz │ <span color=\"${gradients.dark.black20}\">{usage}%</span>";
        on-click = "footclient htop --sort-key PERCENT_CPU";
        min-length = 13;
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
        format-icons = ["" "" ""];
      };
      backlight = {
        device = "acpi_video1";
        format = "{icon}";
        format-icons = [ "" "" "" "" "" "" "" "" "" ];
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
        format-wifi = "  {essid} ({signalStrength}%)";
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
        font-size: 24px;  
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
        font-size: 18px;
        padding: 0px 10px;
        color: ${normal.white};
      }

      #custom-os-icon {
        font-size: 30px;
        margin-right: 0px;
        margin-left: 10px;
        background: ${normal.black};
      }
      #workspaces {
        margin-left: 0px; 
        margin-right: 0px;
      }

      #clock,
      #window {
        font-size: 15px; 
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
        padding: 0px 10px;
        background-color: transparent;
        color: ${normal.white};
      }
      #workspaces button.focused {
        background-color: ${gradients.dark.black00};
        box-shadow: inset 0 -3px ${normal.white};
      }
      #workspaces button.urgent {
        background-color: ${error};
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
      #backlight,
      #bluetooth,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor {
        font-size: 15px;
        border-radius: 3px;
        margin: 0px 10px;
        padding: 0px 10px;
        color: ${normal.black};
      }
      
      #clock {
        font-size: 15px;
        background: ${gradients.dark.black};
        color: ${normal.white};
        padding: 0px 10px;
        margin-left: 0px;
        margin-right: 10px;
      }
      
      #battery {
        background-color: ${normal.green};
        color: ${normal.black};
      }

      #battery.charging,
      #battery.plugged {
        color: ${normal.white};
        background-color: ${normal.yellow};
      }
      
      #cpu {
        background: #2ecc71;
        color: ${normal.black};
      }
      
      #memory {
        background: ${normal.magenta};
      }
      
      #backlight {
        background: transparent;
        color: ${normal.white};
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
        background-color: #fff0f5;
        color: ${gradients.dark.black};
      }
      
      #wireplumber.muted {
        background-color: ${error};
      }
      
      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
      }
      
      #custom-media.custom-spotify {
        background-color: #66cc99;
      }
      
      #temperature {
        background-color: ${normal.orange};
      }
      
      #idle_inhibitor {
        color: ${normal.white};
      }

      #bluetooth {
        background: ${normal.blue};
        color: ${normal.black};
      }
      
      #scratchpad {
        font-size: 15px;
        border-radius: 3px;
        padding: 0px 10px;
        margin-left: 0px;
        background: ${gradients.dark.black05};
        color: ${normal.white};
      }
      #scratchpad.empty {
        background: transparent;
      }    

      #tray {
        background: ${gradients.dark.black00};
      }
      
    '';
  };
}
