{ colorscheme, config, pkgs, lib, ... }:
with colorscheme;
let
  name = "Tony Do";
  user = "tdo";
  email = "tonyttdo@gmail.com";
  main = ./p10k/main.zsh;
  tty = ./p10k/tty.zsh;
  pure = ./p10k/pure.zsh;
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

  bat = {
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

  zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
  };

  jq.enable = true;

  eza.enable = true;

  zsh = {
    enable = true;
    autocd = false;
    cdpath = [ "~/.local/share/src" ];
    envExtra = ''source $HOME/.zshenv-local'';
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
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${gradients.dark.black90}"
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
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
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  alacritty = {
    enable = false;
    settings = {
      live_config_reload = true;
      colors = {
        draw_bold_text_with_bright_colors = true;
        primary = {
          background = "${normal.black}";
          foreground = "${normal.white}";
        };
        bright = {
          black = "${bright.black}";
          red = "${bright.red}";
          green = "${bright.green}";
          yellow = "${bright.yellow}";
          blue = "${bright.blue}";
          magenta = "${bright.magenta}";
          cyan = "${bright.cyan}";
          white = "${bright.white}";
        };
        normal = {
          black = "${normal.black}";
          red = "${normal.red}";
          green = "${normal.green}";
          yellow = "${normal.yellow}";
          blue = "${normal.blue}";
          magenta = "${normal.magenta}";
          cyan = "${normal.cyan}";
          white = "${normal.white}";
        };
      };
      cursor.style = {
        blinking = "On";
      };
      font = {
        builtin_box_drawing = true;
        bold = {
          family = "JetbrainsMono Nerd Font Propo";
          style = "Bold";
        };
        bold_italic = {
          family = "JetbrainsMono Nerd Font Propo";
          style = "Bold Italic";
        };
        italic = {
          family = "JetbrainsMono Nerd Font Propo";
          style = "Italic";
        };
        normal = {
          family = "JetbrainsMono Nerd Font Propo";
          style = "Regular";
        };
        size = 10.0;
      };
      selection.save_to_clipboard = true;
      window.dynamic_title = true;
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

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
      prefix-highlight
      {
        plugin = power-theme;
        extraConfig = ''
           set -g @tmux_power_theme 'gold'
        '';
      }
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    terminal = "screen-256color";
    prefix = "C-x";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = ''
      # Remove Vim mode delays
      set -g focus-events on

      # Enable full mouse support
      set -g mouse on

      # -----------------------------------------------------------------------------
      # Key bindings
      # -----------------------------------------------------------------------------

      # Unbind default keys
      unbind C-b
      unbind '"'
      unbind %

      # Split panes, vertical or horizontal
      bind-key x split-window -v
      bind-key v split-window -h

      # Move around panes with vim-like bindings (h,j,k,l)
      bind-key -n M-k select-pane -U
      bind-key -n M-h select-pane -L
      bind-key -n M-j select-pane -D
      bind-key -n M-l select-pane -R

      # Smart pane switching with awareness of Vim splits.
      # This is copy paste from https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
      '';
    };
}
