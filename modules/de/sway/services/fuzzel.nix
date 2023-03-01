{ colorscheme, ... }: with colorscheme; {
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    prompt="  "
    font=JetBrainsMono Nerd Font
    dpi-aware=yes
    icon-theme=Adwaita

    [dmenu]
    mode=text
    exit-immediately-if-empty=no

    [colors]
    background=${builtins.replaceStrings [ "#" ][ "" ] gradients.dark.black05}ff
    text=${builtins.replaceStrings [ "#" ][ "" ] normal.white}ff
    match=${builtins.replaceStrings [ "#" ][ "" ] normal.green}ff
    selection=${builtins.replaceStrings [ "#" ][ "" ] gradients.dark.black10}ff
    selection-text=${builtins.replaceStrings [ "#" ][ "" ] gradients.light.white00}ff
    border=${builtins.replaceStrings [ "#" ][ "" ] gradients.dark.black05}ff
  '';
}
