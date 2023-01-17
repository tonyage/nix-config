{
  description = "jvm devshell";

  inputs = {
    android.url = "github:tadfisher/android-nixpkgs";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, android, devshell, flake-utils, nixpkgs }:
  {
    overlay = final: _: {
      inherit (self.packages.${final.system}) android-sdk android-studio;
    };
  } // flake-utils.lib.eachSystem [
    flake-utils.lib.system.x86_64-linux
    flake-utils.lib.system.x86_64-darwin
    flake-utils.lib.system.aarch64-darwin
  ] (system:
    let pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        devshell.overlay
        self.overlay
      ];
    };
    in {
      packages = {
        android-sdk = android.sdk.${system} (sdkPkgs: with sdkPkgs; [
          build-tools-33-0-0
          build-tools-30-0-3
          cmdline-tools-latest
          emulator
          platform-tools
          platforms-android-33
          sources-android-33
        ]);
        android-studio = pkgs.androidStudioPackages.stable;
      };
      devShells.default = import ./devshell.nix { inherit pkgs; };
    }
  );
}

