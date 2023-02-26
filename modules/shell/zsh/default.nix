{ colorscheme, lib, pkgs, ... }:
let
  main = ./p10k/.p10k.zsh;
  tty = ./p10k/.p10k.tty.zsh;
in {

  home.packages = with pkgs; [ zoxide ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
      [[ "$(tty)" = "/dev/tty1" ]] && exec sway
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${colorscheme.grey90}"
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ${builtins.readFile ./docker.zsh} 
      ${builtins.readFile ./utils.zsh} 
      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"
    '';

    initExtra = ''
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        [[ ${main} ]] && source ${main}
      else
        [[ -f ${tty} ]] && source ${tty}
      fi
    '';

    plugins = [
      { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; }
      { name = "zsh-autopair"; src = pkgs.zsh-autopair; file = "autopair.zsh"; }

    ];
  };
}
