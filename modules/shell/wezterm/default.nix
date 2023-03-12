{ colorscheme, config, ... }: with colorscheme; {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font {
          family = "JetBrainsMono Nerd Font",
          weight = "Regular",
        },
        font_size = 11.0,
        line_height = 1,
        dpi = 96.0,
        color_scheme_dirs = { "${config.home.homeDirectory}/.config/wezterm/colors" },
        color_scheme = "dusk",
        hide_tab_bar_if_only_one_tab = true,
        underline_thickness = 4.0,
        default_cursor_style = "BlinkingBlock",
        window_padding = {
          left = 0,
          right = 0,
          top = 1,
          bottom = 0,
        },
      }
    '';
    colorSchemes = {
      dusk = {
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
