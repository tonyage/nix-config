{
  description = "home-manager and nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-wl.url = "github:nix-community/nixpkgs-wayland";

    apple-fonts = {
      url = "github:tonyage/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    rust.url = "github:oxalica/rust-overlay";
    devshell.url = "github:numtide/devshell";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self,
    nur,
    darwin,
    nixpkgs,
    apple-fonts,
    home-manager,
    flake-utils,
    devshell,
    rust, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          devshell.overlays.default
          nur.overlay
          rust.overlays.default
        ];
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
      tony = {
        home.homeDirectory = "/home/tony";
        home.username = "tony";
      };
      server = {
        home.homeDirectory = "/home/build";
        home.username = "build";
      };
      colorscheme = {
        _module.args = { colorscheme = import ./colorschemes/dusk.nix; };
      };
    in {
      darwinConfigurations = {
        "m1" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ 
	          ./nixos/darwin-configuration.nix
            home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."tony.do" = {
                imports = [
                  colorscheme
                  ./modules/darwin.nix
                ]; 
              };
            }
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };
      nixosConfigurations = {
        cyclops = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixos/common/configuration.nix
            ./nixos/cyclops/configuration.nix
          ];
        };
        magneto = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixos/common/configuration.nix
            ./nixos/magneto/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "tony@cyclops" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            common
            tony
            ./modules/browser
            ./modules/chat
            ./modules/de
            ./modules/de/sway
            ./modules/shell/ssh
            ./modules/shell/wezterm
          ];
        };
        "tony@jean" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            common
            tony
            ./modules/browser
            ./modules/chat
            ./modules/de/sway
            ./modules/shell/ssh
            ./modules/shell/wezterm
          ];
        };
        "build@magneto" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            common
            server
          ];
        };
      };
      devShells = flake-utils.lib.eachSystem [
        flake-utils.lib.system.x86_64-linux
      ] (system:
        import ./shell.nix { inherit pkgs; }
      );

      templates.jvm = {
        path = ./templates/jvm;
        description = "A devshell for JVM projects";
      };
      templates.cpp = {
        path = ./templates/cpp;
        description = "A devshell for c++ projects";
      };
    };
  }
