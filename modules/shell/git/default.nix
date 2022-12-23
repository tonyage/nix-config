{
  programs.git = {
    enable = true;
    includes = [
      { path = "~/Code/.gitconfig"; condition = "gitdir:~/Code"; }
      { path = "~/git/.gitconfig";  condition = "gitdir:~/git";  }
      { path = "~/work/.gitconfig"; condition = "gitdir:~/work"; }
    ];

    userName = "Tony Do";
    userEmail = "tony.do@pison.com";

    delta = {
      enable = true;
      options = {
        features = "line-numbers decorations";
        decorations = {
          commit-decoraction-style = "blue ol";
          commit-style = "raw";
        };
        syntax-theme = "TwoDark";
      };
    };

    extraConfig = {
      pull.ff = "only";
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
