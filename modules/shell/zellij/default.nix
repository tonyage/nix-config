{ colorscheme, config, pkgs, ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      theme = "dusk";
      themes.dusk = { 
        bg = colorscheme.normal.black;
        fg = colorscheme.normal.white;

        inherit (colorscheme.normal) black;
        inherit (colorscheme.bright) red;
        inherit (colorscheme.bright) green;
        inherit (colorscheme.bright) yellow;
        inherit (colorscheme.bright) blue;
        inherit (colorscheme.bright) magenta;
        inherit (colorscheme.bright) cyan;
        inherit (colorscheme.bright) white;
        inherit (colorscheme.bright) orange;
      };
      copy_on_select = true;
      default_shell = "zsh";
      default_layout = "compact";
      layout_dir = "${config.xdg.configHome}/zellij/layouts";
      copy_command = if pkgs.system == "x86_64-linux" then "wl-copy" else "pb-copy";
    };
  };
  xdg.configFile."zellij/layouts/base.kdl".text = ''
    layout {
      pane_template name="base_pane" {
        children
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }
      tab name="local" {
        base_pane split_direction="horizontal" {
          pane name="neovim"
        }
      }
    }
  '';
  xdg.configFile."zellij/layouts/config.kdl".text = ''
    layout {
      cwd "git/personal/nix-config"
      pane_template name="config_pane" {
        children
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }
      tab name="nix-config" {
        config_pane split_direction="horizontal" {
          pane name="neovim"
          pane split_direction="vertical" size="20%" {
            pane command="home-manager" start_suspended=true {
              args "switch" "--flake" ".#tony@cyclops"
            }
            pane command="sudo" start_suspended=true {
              args "nixos-rebuild" "switch" "--flake" ".#cyclops"
            }
          }
        }
      }
    }
  '';
  xdg.configFile."zellij/layouts/work.kdl".text = ''
    layout {
      cwd "${config.home.homeDirectory}/git/work/pison/libs/core"
      pane_template name="cmake_pane" {
        children
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }
      tab name="work" {
        cmake_pane split_direction="horizontal" {
          pane name="neovim"
          pane command="./build.sh" size="20%" start_suspended=true {
            args "-p" "linux" "-a" "x86_64" "-c" "-l"
          }
        }
      }
    }
  '';
}
