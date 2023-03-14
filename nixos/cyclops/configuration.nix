{ config, lib, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "cyclops";

  environment.systemPackages = [ nvidia-offload ];
  boot.modprobeConfig.enable = true;
  boot.blacklistedKernelModules = [ "i2c_nvidia_gpu" ];

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

  nixpkgs.config.allowUnfree = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };
  services.xserver.videoDrivers = [ "nvidia" "modesetting" ];
  hardware.nvidia.modesetting.enable = true;

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  security.pam.services.swaylock = {
    text = "auth include login";
  };
}

