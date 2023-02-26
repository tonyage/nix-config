{ colorscheme, ... }: with colorscheme; {
  programs.foot = {
    enable = true;
    settings = {
      colors = {
        regular0 = "${normal.black}";
        regular1 = "${normal.red}";
        regular2 = "${normal.green}";
        regular3 = "${normal.yellow}";
        regular4 = "${normal.blue}";
        regular5 = "${normal.magenta}";
        regular6 = "${normal.cyan}";
        regular7 = "${normal.white}";

        bright0 = "${normal.black}";
        bright1 = "${normal.red}";
        bright2 = "${normal.green}";
        bright3 = "${normal.yellow}";
        bright4 = "${normal.blue}";
        bright5 = "${normal.magenta}";
        bright6 = "${normal.cyan}";
        bright7 = "${normal.white}";
      };
      csd = {
        size = 12;
        font = "JetBrainsMono Nerd Font";
        color = "${gradients.dark.black05}";
      };
      cursor = {
        style = "block";
        blink = "yes";
        beam-thickness = "1.25";
      };
      main = {
        font = "JetBrainsMono Nerd Font:size=15";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      mouse-bindings = {
        primary-paste = "BTN_MIDDLE";
        select-begin = "BTN_LEFT";
        select-extend = "BTN_RIGHT";
        select-word = "BTN_LEFT-2";
        select-word-row = "BTN_LEFT-3";
        select-word-whitespace = "Control+BTN_LEFT-2";
      };
      scrollback = {
        lines = 1000000;
        multiplier = 3.0;
      };
    };
  };
}
