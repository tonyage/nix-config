{ colorscheme, pkgs, ... }: with colorscheme; {
  programs.alacritty = {
    enable = true;
    settings = ''
    live_config_reload = true

    [colors]
    draw_bold_text_with_bright_colors = true

    [colors.bright]
    black = "${bright.black}"
    red = "${bright.red}"
    green = "${bright.green}"
    yellow = "${bright.yellow}"
    blue = "${bright.blue}"
    magenta = "${bright.magenta}"
    cyan = "${bright.cyan}"
    white = "${bright.white}"

    [colors.normal]
    black = "${normal.black}"
    red = "${normal.red}"
    green = "${normal.green}"
    yellow = "${normal.yellow}"
    blue = "${normal.blue}"
    magenta = "${normal.magenta}"
    cyan = "${normal.cyan}"
    white = "${normal.white}"

    [cursor]
    blinking = "Always"

    [font]
    normal = { family = "JetbrainsMono Nerd Font", style = "Regular" }
    offset = { x = 0, y = 1 }
    size = 12

    [selection]
    save_to_clipboard = true

    [window]
    dynamic_title = true
    '';
  };
}
