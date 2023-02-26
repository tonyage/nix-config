{
  description = "home-manager and nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwinpkgs = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    rust.url = "github:oxalica/rust-overlay";
    devshell.url = "github:numtide/devshell";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { 
    self,
    nur,
    nixpkgs,
    home-manager,
    flake-utils,
    darwinpkgs,
    devshell,
    rust, ... }@inputs:
    let
      inherit (self) outputs;
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      common = {
        programs.home-manager.enable = true;
        home.stateVersion = "22.11";
        _module.args = { colorscheme = import ./colorschemes/dusk.nix; };
	      imports = [
          ./modules/editor
          ./modules/shell
          ./modules/home.nix
        ];
        systemd.user.startServices = "sd-switch";
      };
      user-common = {
        imports = [ 
	        ./modules/browser
          ./modules/editor
          ./modules/chat
          ./modules/shell
          ./modules/home.nix
	      ];
      };
      system-common = { imports = [ ./nixos/common/configuration.nix ]; };
      tony = {
        home.homeDirectory = "/home/tony";
        home.username = "tony";
      };
      server = {
        home.homeDirectory = "/home/build";
        home.username = "build";
        imports = [
          ./modules/editor
          ./modules/shell
        ];
      };
    in {
      templates.jvm = {
        path = ./templates/jvm;
        description = "jvm devshell";
      };
      nixosConfigurations = {
        cyclops = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            system-common
            ./nixos/cyclops/configuration.nix
          ];
        };
        magneto = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            system-common
            ./nixos/magneto/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "tony@cyclops" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            common
            user-common
            tony
            import ./modules/de/sway
            import ./modules/chat
          ];
        };
        "tony@jean" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            common
            tony
          ];
        };
        "build@magneto" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            common
            server
          ];
        };
      };
      darwinConfigurations = {
        "m1" = darwinpkgs.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          inputs = { inherit darwinpkgs nixpkgs; };
          modules = [ 
            common
            user-common
            home-manager.darwinModules.home-manager {
              users.users."tony.do".home = "/Users/tony.do";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
            }
          ];
        };
      };
    } // flake-utils.lib.eachSystem [
      flake-utils.lib.system.x86_64-linux
      flake-utils.lib.system.aarch64-linux
    ] (system:
      let pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          rust.overlays.default
          devshell.overlay
        ];
      };

      in {
        devShells.default = pkgs.devshell.mkShell {
          imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
        };
      }
    );
}
