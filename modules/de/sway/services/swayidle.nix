{ config, pkgs, ... }: with config; {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 900;
        command = "${pkgs.swaylock}/bin/swaylock -f -i \"${home.homeDirectory}/pics/wallpaper-dark-lock.png\"";
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
        command = "${pkgs.swaylock}/bin/swaylock -f -i \"${home.homeDirectory}/pics/wallpaper-dark-lock.png\"";
      }
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f -i \"${home.homeDirectory}/pics/wallpaper-dark-lock.png\"";
      }
    ];
  };
  systemd.user.services.swayidle.Service.Slice = "session.slice";
}
