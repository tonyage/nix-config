{ config, colorscheme, ... }: with colorscheme; {
  programs.mako = {
    enable = true;
    backgroundColor = "${gradients.dark.black10}";
    borderColor = "${normal.white}";
    textColor = "${normal.white}";
    defaultTimeout = 30000;
    font = "JetBrainsMono Nerd Font 12";
    icons = true;
    maxVisible = 5;
    sort = "-time";
    width = 500;
  };
}
