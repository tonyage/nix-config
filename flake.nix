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
            rust.overlays.default
            devshell.overlay
          ];
          config.allowUnfree = true;
          config.allowUnfreePredicate = _: true;
        };
	      imports = [
          ./modules/editor
          ./modules/shell
          ./modules/misc.nix
        ];
        systemd.user.startServices = "sd-switch";
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

      tony = { ... }: {
        home.homeDirectory = "/home/tony";
        home.username = "tony";
      };

      server = { ... }: {
        home.homeDirectory = "/home/build";
        home.username = "build";
        imports = [
          ./modules/editor
          ./modules/shell
        ];
      };

    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );
      overlays = import ./overlays;
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
        in pkgs.devshell.mkShell {
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
            tony
            import [ ./modules/de ]
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
