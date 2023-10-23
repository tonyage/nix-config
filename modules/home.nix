{ config, lib, inputs, pkgs, ... }: with config; {
  fonts.fontconfig.enable = true;
  targets.genericLinux.enable = true;
  home.packages = with pkgs; [
    zip
    rustup
    ripgrep
    noto-fonts
    noto-fonts-emoji
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro
    (nerdfonts.override { 
      fonts = [ "JetBrainsMono" ];
    })
    xclip
    protobuf
  ] ++ lib.optionals stdenv.isLinux [
    nixgl.nixGLIntel
    nixgl.nixVulkanIntel
  ];
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
  xdg.userDirs = {
    enable = true;
    desktop = "${home.homeDirectory}/";
    music = "${home.homeDirectory}/";
    templates = "${home.homeDirectory}/";
    videos = "${home.homeDirectory}/";

    documents = "${home.homeDirectory}/git";
    download = "${home.homeDirectory}/dl";
    publicShare = "${home.homeDirectory}/pub";
    pictures = "${home.homeDirectory}/pics";
  };
}
