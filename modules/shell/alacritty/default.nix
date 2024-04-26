{ colorscheme, pkgs, ... }: with colorscheme; {
  programs.alacritty = {
    enable = false;
    package = pkgs.alacritty;
    settings = {
      live_config_reload = true;

      colors.draw_bold_text_with_bright_colors = true;

      colors.primary = {
        background = "${normal.black}";
        foreground = "${normal.white}";
      };

      colors.bright = {
        black = "${bright.black}";
        red = "${bright.red}";
        green = "${bright.green}";
        yellow = "${bright.yellow}";
        blue = "${bright.blue}";
        magenta = "${bright.magenta}";
        cyan = "${bright.cyan}";
        white = "${bright.white}";
      };

      colors.normal = {
        black = "${normal.black}";
        red = "${normal.red}";
        green = "${normal.green}";
        yellow = "${normal.yellow}";
        blue = "${normal.blue}";
        magenta = "${normal.magenta}";
        cyan = "${normal.cyan}";
        white = "${normal.white}";
      };

      cursor.style = {
        blinking = "On";
      };

      font = {
        builtin_box_drawing = true;
        bold = {
          family = "JetbrainsMono Nerd Font Propo";
          style = "Bold";
        };
        bold_italic = {
          family = "JetbrainsMono Nerd Font Propo";
          style = "Bold Italic";
        };
        italic = {
          family = "JetbrainsMono Nerd Font Propo";
          style = "Italic";
        };
        normal = {
          family = "JetbrainsMono Nerd Font Propo";
          style = "Regular";
        };
        size = 10.0;
      };

      selection.save_to_clipboard = true;
      window.dynamic_title = true;
    };
  };
}
