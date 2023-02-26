# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  documentation.nixos.enable = false;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

  programs.dconf.enable = true;
  programs.zsh.enable = true;

  hardware.video.hidpi.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;

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
        xdg-desktop-portal-gt k
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    fd
    exa
    git
    curl
    gnused
    neovim
    zoxide
    ripgrep
    binutils
    patchelf
    coreutils
    findutils
    inotify-tools
  ];

  environment.shells = with pkgs; [ zsh ];

  services.openssh.enable = true;
  services.printing.enable = true;

  virtualisation.docker = { 
    enable = true;
    autoPrune.enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  system.autoUpgrade.enable = true;
  system.stateVersion = "22.05";
}

