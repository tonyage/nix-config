{ pkgs, ... }: {
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}
