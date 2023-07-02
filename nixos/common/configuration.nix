# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs, ... }: {

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amd_iommu=on" ];

  boot.extraModprobeConfig = "options vfio-pci ids=10de:2206,10de:1aef";

  boot.kernelModules = [
    "kvm-amd"
    "vfio_virqfd"
    "vfio_pci"
    "vfio_iommu_type1"
    "vfio"
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  boot.postBootCommands = ''
    DEVS="0000:0c:00.0 0000:0c:00.1"
    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    done
    modprobe -i vfio-pci
  '';

  documentation.nixos.enable = false;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.light.enable = true;

  sound.enable = true;
  hardware.bluetooth.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.xserver.libinput.enable = true;
  environment.binsh = "${pkgs.dash}/bin/dash";

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    lshw
    gnused
    ripgrep
    binutils
    usbutils
    patchelf
    coreutils
    findutils
    pulseaudio
    virtmanager
    inotify-tools
  ];

  fonts.fonts = [ inputs.apple-fonts.packages.${pkgs.system}.sf-pro ];

  environment.shells = with pkgs; [ zsh ];

  services.openssh.enable = true;

  services.printing.enable = true;
  services.blueman.enable = true;
  services.hardware.bolt.enable = true;

  virtualisation.docker = { 
    enable = true;
    autoPrune.enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
    };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
  system.stateVersion = "22.05";
}

