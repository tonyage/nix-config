{ config, lib, pkgs, ... }: with config; {
  fonts.fontconfig.enable = true;
  targets.genericLinux.enable = true;
  home.packages = with pkgs; [
    zip
    ripgrep
    noto-fonts
    nil
    nixpkgs-fmt
    noto-fonts-emoji
    (nerdfonts.override { 
      fonts = [ "JetBrainsMono" ];
    })
    xclip
    protobuf
  ] ++ lib.optionals stdenv.isLinux [
    nixgl.nixGLIntel
    nixgl.nixVulkanIntel
  ];
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
