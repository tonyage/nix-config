{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "cyclops";

  users.users.tony = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "input" ];
    shell = pkgs.zsh;
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

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

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  security.pam.services.swaylock = {
    text = "auth include login";
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

