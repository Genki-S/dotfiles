#!/usr/bin/env zsh

# Downloads pre-built binaries hosted on the Internet and installs in $HOME/bin

set -euo pipefail
set -x

BIN_INSTALL_DIR="$HOME/bin"
mkdir -p "$BIN_INSTALL_DIR"
COMPLETION_INSTALL_DIR="$HOME/zsh-completions"
mkdir -p "$COMPLETION_INSTALL_DIR"

tmpdir="$(mktemp -d)"

# https://github.com/knqyf263/pet
petdir="$tmpdir/pet"
mkdir $petdir
curl \
  -L \
  'https://github.com/knqyf263/pet/releases/download/v0.3.6/pet_0.3.6_linux_amd64.tar.gz' \
  -o "$petdir/pet.tar.gz"
tar xvzf "$petdir/pet.tar.gz" -C "$petdir/"
mv "$petdir/pet" "$BIN_INSTALL_DIR/pet"
mv "$petdir/misc/completions/zsh/_pet" "$COMPLETION_INSTALL_DIR/_pet"
