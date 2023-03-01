{
  name = "dusk";

  gradients = {
    # 5% brighter for black/grey gradients
    dark = {
      black   = "#000000";
      black00 = "#161616";
      black05 = "#222222";
      black10 = "#2d2d2d";
      black15 = "#393939";
      black20 = "#454545";
      black25 = "#505050";
      black90 = "#707070";
    };
    light = {
      white   = "#ffffff";
      white00 = "#abb2bf";
      white05 = "#b5bcc9";
      white10 = "#b9bfcc";
      white15 = "#bcc3ce";
      white20 = "#c4c9d4";
      white25 = "#c7cdd6";
      white90 = "#f8f8fa";
    };
  };

  normal = {
    black   = "#161616";
    red     = "#ef596f";
    green   = "#89ca78";
    yellow  = "#e5c07b";
    blue    = "#61afef";
    magenta = "#c678dd";
    cyan    = "#60c0cc";
    white   = "#abb2bf";
    orange  = "#ea9560";
  };

  # 10% brighter
  bright = {
    black   = "#222222";
    red     = "#f96379";
    green   = "#93d482";
    yellow  = "#efca85";
    blue    = "#6bb9f9";
    magenta = "#df69e8";
    cyan    = "#6fcfdb";
    white   = "#b5bcc9";
    orange  = "#f49f6a";
  };

  dim = {};

  foot = {
    regular = {
      regular0 = builtins.replaceStrings [ "#" ][ "" ] "#161616";
      regular1 = builtins.replaceStrings [ "#" ][ "" ] "#ef596f";
      regular2 = builtins.replaceStrings [ "#" ][ "" ] "#89ca78";
      regular3 = builtins.replaceStrings [ "#" ][ "" ] "#e5c07b";
      regular4 = builtins.replaceStrings [ "#" ][ "" ] "#61afef";
      regular5 = builtins.replaceStrings [ "#" ][ "" ] "#c678dd";
      regular6 = builtins.replaceStrings [ "#" ][ "" ] "#60c0cc";
      regular7 = builtins.replaceStrings [ "#" ][ "" ] "#abb2bf";
    };
    bright = {
      bright0 = builtins.replaceStrings [ "#" ][ "" ] "#393939";
      bright1 = builtins.replaceStrings [ "#" ][ "" ] "#f96379";
      bright2 = builtins.replaceStrings [ "#" ][ "" ] "#93d482";
      bright3 = builtins.replaceStrings [ "#" ][ "" ] "#efca85";
      bright4 = builtins.replaceStrings [ "#" ][ "" ] "#6bb9f9";
      bright5 = builtins.replaceStrings [ "#" ][ "" ] "#df69e8";
      bright6 = builtins.replaceStrings [ "#" ][ "" ] "#6fcfdb";
      bright7 = builtins.replaceStrings [ "#" ][ "" ] "#b5bcc9";
    };
  };

  black   = "#161616";
  red     = "#ef596f";
  green   = "#89ca78";
  yellow  = "#e5c07b";
  blue    = "#61afef";
  magenta = "#c678dd";
  cyan    = "#60c0cc";
  white   = "#abb2bf";
  orange  = "#ea9560";
  error   = "#f44747";

  base00 = "#161616";
  base01 = "#222222";
  base02 = "#2d2d2d";
  base03 = "#393939";
  base04 = "#454545";
  base05 = "#505050";
  base06 = "#abb2bf";
  base07 = "#b5bcc9";
  base08 = "#ef596f";
  base09 = "#ea9560";
  base0A = "#e5c07b";
  base0B = "#89ca78";
  base0C = "#60c0cc";
  base0D = "#6bb9f9";
  base0E = "#d55fde";
  base0F = "#f44747";

  diff = {
    green = "#d0ffd0";
    dark-green = "#a0efa0";
  };
  misc = {
    pink = "#de8c92";
  };
}
