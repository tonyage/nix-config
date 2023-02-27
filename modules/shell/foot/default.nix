{ colorscheme, pkgs, ... }: with colorscheme;
let
  fontSize = 11;
in {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      colors = {
        background = "${builtins.replaceStrings [ "#" ][ "" ] gradients.dark.black00}";
        foreground = "${builtins.replaceStrings [ "#" ][ "" ] normal.white}";

        # regular0 = "${foot.black}";
        # regular1 = "${foot.red}";
        # regular2 = "${foot.green}";
        # regular3 = "${foot.yellow}";
        # regular4 = "${foot.blue}";
        # regular5 = "${foot.magenta}";
        # regular6 = "${foot.cyan}";
        # regular7 = "${foot.white}";
        
        inherit (foot.regular) regular0;
        inherit (foot.regular) regular1;
        inherit (foot.regular) regular2;
        inherit (foot.regular) regular3;
        inherit (foot.regular) regular4;
        inherit (foot.regular) regular5;
        inherit (foot.regular) regular6;
        inherit (foot.regular) regular7;

        inherit (foot.bright) bright0;
        inherit (foot.bright) bright1;
        inherit (foot.bright) bright2;
        inherit (foot.bright) bright3;
        inherit (foot.bright) bright4;
        inherit (foot.bright) bright5;
        inherit (foot.bright) bright6;
        inherit (foot.bright) bright7;
      };
      csd = {
        size = fontSize;
        font = "JetBrainsMono Nerd Font";
        color = "${foot.regular.regular0}";
      };
      cursor = {
        style = "block";
        blink = "yes";
        beam-thickness = "1.25";
      };
      main = {
        font = "JetBrainsMono Nerd Font:size=${builtins.toString fontSize}";
        dpi-aware = "no";
        shell = "${pkgs.zsh}/bin/zsh";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      mouse-bindings = {
        primary-paste = "BTN_MIDDLE";
        select-begin = "BTN_LEFT";
        select-extend = "BTN_RIGHT";
        select-word = "BTN_LEFT-2";
        select-row = "BTN_LEFT-3";
        select-word-whitespace = "Control+BTN_LEFT-2";
      };
      scrollback = {
        lines = 1000000;
        multiplier = 3.0;
      };
    };
  };
}
