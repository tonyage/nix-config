{ colorscheme, ... }: with colorscheme; {
  programs.foot = {
    enable = true;
    settings = {
      colors = {
        background = "${foot.black}";
        foreground = "${foot.white}";

        regular0 = "${foot.black}";
        regular1 = "${foot.red}";
        regular2 = "${foot.green}";
        regular3 = "${foot.yellow}";
        regular4 = "${foot.blue}";
        regular5 = "${foot.magenta}";
        regular6 = "${foot.cyan}";
        regular7 = "${foot.white}";

        bright0 = "${foot.black}";
        bright1 = "${foot.red}";
        bright2 = "${foot.green}";
        bright3 = "${foot.yellow}";
        bright4 = "${foot.blue}";
        bright5 = "${foot.magenta}";
        bright6 = "${foot.cyan}";
        bright7 = "${foot.white}";
      };
      csd = {
        size = 12;
        font = "JetBrainsMono Nerd Font";
        color = "${foot.black05}";
      };
      cursor = {
        style = "block";
        blink = "yes";
        beam-thickness = "1.25";
      };
      main = {
        font = "JetBrainsMono Nerd Font:size=13";
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
