{
  description = "home-manager and nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-wl.url = "github:nix-community/nixpkgs-wayland";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";

    flake-utils.url = "github:numtide/flake-utils";
    rust.url = "github:oxalica/rust-overlay";
    devshell.url = "github:numtide/devshell";
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    { self
    , nur
    , darwin
    , nixpkgs
    , home-manager
    , flake-utils
    , devshell
    , nixgl
    , rust
    , ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          devshell.overlays.default
          rust.overlays.default
          nixgl.overlay
          nur.overlay
        ];
      };
      common = {
        programs.home-manager.enable = true;
        home.stateVersion = "22.11";
        _module.args = { colorscheme = import ./colorschemes/dusk.nix; };
        imports = [
          ./modules/editor/nvim
          ./modules/shell
          ./modules/home.nix
        ];
        systemd.user.startServices = "sd-switch";
      };
      disableHomeManagerNews = {
        config = {
          news.display = "silent";
        };
      };
      tony = {
        home.homeDirectory = "/home/tony";
        home.username = "tony";
        imports = [
          ./modules/chat.nix
          ./modules/editor/jetbrains
          ./modules/shell/wezterm
          ./modules/shell/ssh
          ./modules/entries
        ];
      };
      colorscheme = {
        _module.args = { colorscheme = import ./colorschemes/dusk.nix; };
      };
    in
    {
      darwinConfigurations = {
        "m1" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nixos/darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
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
      homeConfigurations = {
        "tony@cable" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ common disableHomeManagerNews tony ];
        };
      };
      devShells = flake-utils.lib.eachSystem [
        flake-utils.lib.system.x86_64-linux
      ]
        (_:
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
