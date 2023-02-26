#!/usr/bin/env bash

set -euo pipefail

echo -e "Setting up new ssh keys."
mkdir -p "$HOME/.ssh"
pushd "$HOME/.ssh" > /dev/null || exit
  ssh-keygen -t ed25519 -f personal -q -N ""
  ssh-keygen -t ed25519 -f work -q -N ""
popd > /dev/null || exit
