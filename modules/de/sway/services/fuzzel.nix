{ colorscheme, ... }: with colorscheme; {
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    font=JetBrainsMono
    dpi-aware=yes

    [colors]
    background=${base01}ff
    text=${white}ff
    match=${green}ff
    selection=${blue}ff
    selection-text=${black}ff
    border=${base01}ff
  '';
}
