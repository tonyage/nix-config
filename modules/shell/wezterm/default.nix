{ colorscheme, config, pkgs, ... }: with colorscheme;
let
  fontSize = if pkgs.system == "x86_64-linux" then "10.0" else "14.0";
  lineHeight = "1.2";
in
{
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = ''
      return {
        font = wezterm.font_with_fallback {
          { family = "JetBrainsMono Nerd Font Propo", weight = "Regular" }, 
          "Noto Color Emoji"
        },
        font_size = ${fontSize},
        line_height = ${lineHeight},
        color_scheme_dirs = { "${config.home.homeDirectory}/.config/wezterm/colors" },
        color_scheme = "dusk",
        hide_tab_bar_if_only_one_tab = true,
        underline_position = -12,
        underline_thickness = 2.0,
        use_fancy_tab_bar = false,
        tab_max_width = 16,
        default_cursor_style = "BlinkingBlock",
        initial_rows = 40,
        initial_cols = 200,
        warn_about_missing_glyphs = false,
        window_decorations = "RESIZE",
        window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        },
        keys = {
          { 
            key = 'Backspace',
            mods = 'CTRL',
            action = wezterm.action.SendKey {
              key = 'Backspace',
              mods = 'ALT'
            }
          },
          {
            key = 'Backspace',
            mods = 'CTRL',
            action = wezterm.action.SendKey {
              key = 'w',
              mods = 'CTRL'
            }
          },
          {
            key = '-',
            mods = 'ALT',
            action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
          },
          {
            key = '/',
            mods = 'ALT',
            action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
          }
        }
      }
    '';
    colorSchemes = {
      dusk = {
        tab_bar = {
          background = normal.black;
          active_tab = {
            bg_color = normal.black;
            fg_color = normal.white;
            intensity = "Bold";
            underline = "None";
          };
          inactive_tab = {
            bg_color = gradients.dark.black10;
            fg_color = normal.white;
            intensity = "Normal";
            underline = "None";
          };
        };
        ansi = [
          normal.black
          normal.red
          normal.green
          normal.yellow
          normal.blue
          normal.magenta
          normal.cyan
          normal.white
        ];
        brights = [
          gradients.dark.black10
          bright.red
          bright.green
          bright.yellow
          bright.blue
          bright.magenta
          bright.cyan
          bright.white
        ];
        background = normal.black;
        foreground = normal.white;

        cursor_bg = normal.white;
        cursor_fg = normal.black;
        cursor_border = normal.white;

        selection_bg = gradients.dark.black15;
      };
    };
  };
}
