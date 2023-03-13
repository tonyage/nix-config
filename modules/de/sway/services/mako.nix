{ config, colorscheme, ... }: with colorscheme; {
  services.mako = {
    enable = true;
    backgroundColor = "${gradients.dark.black05}";
    borderColor = "${gradients.dark.black05}";
    borderSize = 1;
    textColor = "${normal.white}";
    defaultTimeout = 30;
    font = "JetBrainsMono Nerd Font 12";
    icons = true;
    maxVisible = 5;
    sort = "-time";
    width = 500;
  };
}
