{ colorscheme, ... }: with colorscheme; {
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    prompt="  "
    font=JetBrainsMono Nerd Font
    dpi-aware=yes

    [colors]
    background=${foot.black05}ff
    text=${foot.white}ff
    match=${foot.green}ff
    selection=${foot.blue}ff
    selection-text=${foot.black}ff
    border=${foot.black05}ff
  '';
}
