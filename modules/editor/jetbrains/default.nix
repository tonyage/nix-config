{ pkgs, ... }: {
  imports = [ ./remote.nix ];
  services.idea-ultimate-remote.enable = true;
}
