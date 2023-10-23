{ pkgs, ... }: let ip = "192.168.0.60"; in {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "magneto";

  security.tpm2.enable = true;
  security.tpm2.tctiEnvironment.enable = true;

  users.users.tony = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "tss" "adbusers" ];
    shell = pkgs.zsh;
  };

  programs.adb.enable = true;

  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };

  services.udev.packages = [ pkgs.android-udev-rules ];

  hardware.opengl.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

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

  security.pam.services.swaylock = {
    text = "auth include login";
  };
}

