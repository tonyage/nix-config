{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = { 
      theme = "base16";
      pager = "less -FR";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
      batwatch 
      prettybat
    ];
  };
}
