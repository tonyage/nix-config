{ colorscheme, config, pkgs, ... }: with colorscheme;
let 
  dpi = if pkgs.system == "x86_64-linux" then "192.0" else "144.0";
  fontSize = if pkgs.system == "x86_64-linux" then "10.0" else "14.0";
  lineHeight = "1.2";
in {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = ''
      return {
        font = wezterm.font {
          family = "JetBrainsMono Nerd Font",
          weight = "Regular",
        },
        font_size = ${fontSize},
        line_height = ${lineHeight},
        dpi = ${dpi},
        color_scheme_dirs = { "${config.home.homeDirectory}/.config/wezterm/colors" },
        color_scheme = "dusk",
        hide_tab_bar_if_only_one_tab = true,
        underline_position = -12,
        underline_thickness = 2.0,
        use_fancy_tab_bar = false,
        tab_bar_at_bottom = true,
        default_cursor_style = "BlinkingBlock",
        window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        },
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
          bright.black
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
