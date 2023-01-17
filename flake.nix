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
    nurpkgs.url = "github:nix-community/NUR";
    rust.url = "github:oxalica/rust-overlay";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, darwinpkgs, devshell, nurpkgs, rust, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      common = {
        programs.home-manager.enable = true;
        home.stateVersion = "22.11";
        _module.args = { colorscheme = import ./colorschemes/dusk.nix; };
        nixpkgs = {
          overlays = [
            nurpkgs.overlay
            rust.overlays.default
            devshell.overlay
          ];
          config.allowUnfree = true;
          config.allowUnfreePredicate = _: true;
        };
      };

      user-common = { ... }: {
        imports = [ 
	        ./modules/browser
          ./modules/editor
          ./modules/chat
          ./modules/shell
          ./modules/misc.nix
	      ];
      };

      system-common = { ... }: {
        imports = [ ./nixos/common/configuration.nix ];
      };

      linux = { ... }: {
        home.homeDirectory = "/home/tony";
        home.username = "tony";
	      imports = [ ./modules/de ];
        systemd.user.startServices = "sd-switch";
      };

      server = { ... }: {
        home.homeDirectory = "/home/build";
        home.username = "build";
        imports = [
          ./modules/editor
          ./modules/shell
        ];
        systemd.user.startServices = "sd-switch";
      };

    in {
      overlays = import ./overlays;

      devShell = forAllSystems (system:
        let pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
        in pkgs.devshell.mkShell {
          envs = [
            {
              name = "NIX_CONFIG";
              value = "experimental-features = nix-command flakes";
            }
          ];
          imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
        }
      );

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
	          linux
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
          inputs = { inherit darwinpkgs nixpkgs; };
          modules = [ 
            common
            user-common
            home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      };
    };
}
