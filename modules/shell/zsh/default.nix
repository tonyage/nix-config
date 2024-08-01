{ colorscheme, config, pkgs, ... }:
with colorscheme;
let
  main = ./p10k/main.zsh;
  tty = ./p10k/tty.zsh;
  pure = ./p10k/pure.zsh;
in
{
  programs.fzf = {
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

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = import ../aliases.nix;
    defaultKeymap = "emacs";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    initExtraBeforeCompInit = ''
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      fpath+=("/usr/share/zsh/site-functions")
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${gradients.dark.black90}"
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ${builtins.readFile ./docker.zsh} 
      ${builtins.readFile ./utils.zsh} 
      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"
    '';

    initExtraFirst = ''
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        if [ "''${TERM}" = "alacritty" ] || [ "''${TERMINAL_EMULATOR}" = "JetBrains-JediTerm" ]; then
          source ${pure}
        else
          source ${main}
        fi
      else 
        source ${tty}
      fi
      # eval "$(zellij setup --generate-auto-start zsh)"
    '';
    envExtra = ''source $HOME/.zshenv-local'';
    plugins = [
      { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; }
      { name = "zsh-autopair"; src = pkgs.zsh-autopair; file = "share/zsh/zsh-autopair/autopair.zsh"; }
    ];
  };
}
