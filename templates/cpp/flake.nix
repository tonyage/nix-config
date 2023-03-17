{
  description = "developer environment for pison monorepo";

  inputs = {
    android.url = "github:tadfisher/android-nixpkgs";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, android, devshell, flake-utils, nixpkgs }:
  {
    overlays = final: prev: {
      inherit (self.packages.${final.system}) android-sdk android-studio;
      spdlog = prev.spdlog.overrideAttrs (oa: {
        cmakeFlags = oa.cmakeFlags ++ [
          "-DSPDLOG_FMT_EXTERNAL=OFF"
          "-DSPDLOG_BUILD_STATIC=ON"
        ];
      });
      protobuf = prev.protobuf.overrideAttrs (oa: {
        cmakeFlags = oa.cmakeFlags ++ [
          "-Dprotobuf_BUILD_SHARED_LIBS=OFF"
        ];
      });
    };
  } // flake-utils.lib.eachSystem [
    flake-utils.lib.system.x86_64-linux
    flake-utils.lib.system.x86_64-darwin
    flake-utils.lib.system.aarch64-darwin
  ] (system: 
    let
      inherit (nixpkgs) lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          devshell.overlays.default
          self.overlays
        ];
      };
    in { 
      packages = {
        android-sdk = android.sdk.${system} (sdkPkgs: with sdkPkgs; [
          build-tools-33-0-2
          build-tools-30-0-3
          cmake-3-22-1
          cmdline-tools-latest
          emulator
          patcher-v4
          platforms-android-33
          platform-tools
          sources-android-33
        ]);
        android-studio = pkgs.androidStudioPackages.stable;
      };
      devShells.default = import ./devshell.nix { inherit lib pkgs; };
    }
  );
}
