{ colorscheme, ... }: with colorscheme; {
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    prompt="  "
    font=JetBrainsMono Nerd Font
    dpi-aware=yes

    [colors]
    background=${builtins.replaceStrings [ "#" ][ "" ] gradients.dark.black05}ff
    text=${builtins.replaceStrings [ "#" ][ "" ] normal.white}ff
    match=${builtins.replaceStrings [ "#" ][ "" ] normal.green}ff
    selection=${builtins.replaceStrings [ "#" ][ "" ] normal.blue}ff
    selection-text=${builtins.replaceStrings [ "#" ][ "" ] gradients.dark.black00}ff
    border=${builtins.replaceStrings [ "#" ][ "" ] gradients.dark.black05}ff
  '';
}
