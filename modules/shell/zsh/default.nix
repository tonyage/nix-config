{ colorscheme, lib, pkgs, ... }:
let
  main = ./p10k/.p10k.zsh;
  tty = ./p10k/.p10k.tty.zsh;
in {

  home.packages = with pkgs; [ zoxide ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # home manager says colors option doesn't exist but the docs say otherwise
    # FIXME:
    # colors = ''
    # {
    #   bg      = colorscheme.black;
    #   "bg+"   = colorscheme.black;
    #   fg      = colorscheme.white;
    #   "fg+"   = colorscheme.green;
    #   hl      = colorscheme.blue;
    #   "hl+"   = colorscheme.cyan;
    #   info    = colorscheme.yellow;
    #   marker  = colorscheme.green;
    #   prompt  = colorscheme.red;
    #   spinner = colorscheme.blue;
    #   pointer = colorscheme.magenta;
    #   header  = "#FFFFFF";
    # }'';

    defaultCommand = "fd --type f --strip-cwd-prefix";
    fileWidgetCommand = "fd --type f --strip-cwd-prefix --exclude .git";
    defaultOptions = [
      "--border"
      "--color fg:${colorscheme.white},fg+:${colorscheme.green},bg:${colorscheme.black},bg+:${colorscheme.black}"
      "--color hl:${colorscheme.blue},hl+:${colorscheme.cyan},info:${colorscheme.yellow},prompt:${colorscheme.red}"
      "--color spinner:${colorscheme.blue},pointer:${colorscheme.magenta},header:#FFFFFF"
    ];
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = import ./aliases.nix;
    defaultKeymap = "viins";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      JAVA_HOME = "${pkgs.jdk11}";
    };

    initExtraBeforeCompInit = ''
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=${colorscheme.grey90}'
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ${builtins.readFile ./docker.zsh} 
      ${builtins.readFile ./utils.zsh} 
      eval $(zoxide init zsh)
      eval $(direnv hook zsh)
    '';

    initExtra = ''
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        [[ ! -f ${main} ]] || source ${main}
      else
        [[ ! -f ${tty} ]] || source ${tty}
      fi
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "adb" "colored-man-pages" "cp" "fd" "fzf" "gradle" "ripgrep" "rust" "web-search" "zoxide" ];
    };

    plugins = [
      { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; }
    ];
  };
}
