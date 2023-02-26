{ pkgs, ... }: {
  systemd.user.services.mako = {
    Unit = {
      Description = "Notification daemon for Wayland";
      Documentatio = "man:mako(1)";
      After = "graphical-session-pre.target";
      PartOf = "sway-session.target"; # Should be terminated when the session ends.
    };
    Service = {
      Slice = "session.slice";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "always";
    };
    Install.WantedBy = [ "sway-session.target" ];
  };
}
