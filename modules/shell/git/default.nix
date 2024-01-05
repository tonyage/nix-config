{
  programs.git = {
    enable = true;
    includes = [
      { path = "~/git/personal/.gitconfig";  condition = "gitdir:~/git/personal";  }
      { path = "~/git/work/.gitconfig"; condition = "gitdir:~/git/work"; }
    ];

    aliases = {
      ra = "rebase --abort";
      rc = "rebase --continue";
      ma = "merge --abort";
      mc = "merge --continue";
      plog = "log --all --decorate --oneline --graph";
    };

    delta = {
      enable = true;
      options = {
        features = "line-numbers decorations";
        decorations = {
          commit-style = "raw";
        };
        syntax-theme = "base16";
      };
    };

    userName = "Tony Do";
    userEmail = "tonyttdo@gmail.com";

    extraConfig = {
      pull.rebase = "merges";
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      difftool.prompt = true;
      diff.tool = "nvimdiff";
      "difftool \"nvimdiff\"".cmd = "nvim -d $LOCAL $REMOTE";
      merge.conflictstyle = "zdiff3";
    };
  };

  programs.gh = {
   enable = true;
    settings = {
      git_protocol = "ssh";
      editor = "nvim";
    };
  };
}
