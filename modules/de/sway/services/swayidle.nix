{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 900;
        command = "${pkgs.swaylock}/bin/swaylock -f -i \"../../assets/wallpaper-dark.jpg\"";
      }
      {
        timeout = 1200;
        command = ''${pkgs.sway}/bin/swaymsg "output * power off"'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      }
    ];
    events = [
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -f -i \"../../assets/wallpaper-dark.jpg\"";
      }
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f -i \"../../assets/wallpaper-dark.jpg\"";
      }
    ];
  };
}
