{ colorscheme, config, pkgs, lib, ... }:
with colorscheme;
let
  name = "Tony Do";
  user = "tdo";
  email = "tonyttdo@gmail.com";
  main = ./config/p10k/main.zsh;
  tty = ./config/p10k/tty.zsh;
  pure = ./config/p10k/pure.zsh;
  # wezterm = import ./shell/wezterm { inherit colorscheme config pkgs; };
in {
  # Shared shell configuration
  fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --strip-cwd-prefix";
    fileWidgetCommand = "fd --type f --strip-cwd-prefix --exclude .git";
    defaultOptions = [
      "--border"
      "--color fg:${normal.white},fg+:${normal.green},bg:${normal.black},bg+:${normal.black}"
      "--color hl:${normal.blue},hl+:${normal.cyan},info:${normal.yellow},prompt:${normal.red}"
      "--color spinner:${normal.blue},pointer:${normal.magenta},header:${normal.white}"
    ];
  };

  # inherit wezterm;

  bat = {
    enable = true;
    config = {
      theme = "base16-256";
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

  zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
  };

  jq.enable = true;

  eza.enable = true;
  direnv.enable = true;
  direnv.nix-direnv.enable = true;

  zsh = {
    enable = true;
    defaultKeymap = "emacs";
    envExtra = ''source $HOME/.zshenv-local'';
    shellAliases = import ./config/zsh/aliases.nix;
    autosuggestion = {
      enable = true;
      highlight = "fg=${gradients.dark.black90}";
      strategy = [ "history" "completion" ];
    };
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    plugins = [
      { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; }
      { name = "zsh-autopair"; src = pkgs.zsh-autopair; file = "share/zsh/zsh-autopair/autopair.zsh"; }
    ];
    initExtraBeforeCompInit = ''
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      fpath+=("/usr/share/zsh/site-functions")
      fpath+=("/opt/homebrew/share/zsh/site-functions")
      ${builtins.readFile ./config/zsh/docker.zsh}
      ${builtins.readFile ./config/zsh/utils.zsh}
      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"
    '';
    initExtraFirst = ''
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        if [ "''${TERM}" = "alacritty" ] || [ "''${TERMINAL_EMULATOR}" = "JetBrains-JediTerm" ] || [ "''${TERM_PROGRAM}" = "Apple_Terminal" ]; then
          source ${pure}
        else
          source ${main}
        fi
      else
        source ${tty}
      fi
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
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
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	      editor = "nvim";
        autocrlf = "input";
      };
      push.autoSetupRemote = true;
      # commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };
}
