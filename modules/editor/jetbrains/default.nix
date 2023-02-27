{ pkgs, ... }: {
  imports = [ ./remote.nix ];
  home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];
  services.idea-ultimate-remote.enable = true;
}
