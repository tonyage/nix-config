#!/usr/bin/env zsh

flakify() {
  if [ ! -e flake.nix ]; then
    nix flake new -t github:nix-community/nix-direnv
  elif [ ! -e .envrc ]; then
    echo "use flake" > .envrc
    direnv allow
  fi
  "${EDITOR:-nvim}" flake.nix
}

jvm-flakify() {
  if [ ! -e flake.nix ]; then
    nix flake new -t github:tonyage/nix
  elif [ ! -e .envrc ]; then
    echo "use flake" > .envrc
    direnv allow
  fi
  "${EDITOR:-nvim}" flake.nix
}

gi() {
  curl -sL https://www.gitignore.io/api/$argv >> ./.gitignore
}

bdiff() {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

help() {
  "$@" --help 2>&1 | bat --plain --language=help
}

chpwd() {
  echo "\x1b]1337;SetUserVar=panetitle=$(echo -n $(basename $(pwd)) | base64)\x07"
}

trn() {
  wezterm cli set-tab-title "$@"
}
