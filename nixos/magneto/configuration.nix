{ pkgs, ... }: let ip = "192.168.0.60"; in {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "magneto";

  users.users.build = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "build";

  services.openssh = {
    enable = true;
    settings = {
      passwordAuthentication = false;
      permitRootLogin = "no";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  virtualisation.oci-containers.containers = {
    pihole = {
      image = "pihole/pihole:latest";
      ports = [
        "${ip}:53:53/tcp"
        "${ip}:53:53/udp"
        "3080:80"
        "30443:443"
      ];
      volumes = [
        "/var/lib/pihole:/etc/pihole"
        "var/lib/dnsmasq.d:/etc/dnsmasq.d"
      ];
      environment = {
        ServerIP = ip;
      };
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--dns=127.0.0.1"
        "--dns=1.1.1.1"
      ];
      workdir = "/var/lib/pihole";
    };
  };
}

