#!/bin/bash

set -euxo pipefail

function wait_enter() {
  echo "Press [Enter] to continue:"
}

# Install pre-dotfiles requisits
echo "Installing required packages"
sudo pacman -S xclip
sudo pacman -S openssh

echo "Generating ssh key"
ssh-keygen -t rsa

echo "Copying ssh pubkey to clipboard"
cat ~/.ssh/id_rsa.pub | xclip -sel clip

echo "Now register the SSH key to GitHub"
xdg-open https://github.com/login
wait_enter

git clone git@github.com:Genki-S/dotfiles $HOME/dotfiles
(cd $HOME/dotfiles && git submodule --update --init)

# read Pacfile and install
while read pkg; do
  if [[ "$pkg" = \#* ]] || [[ -z "$pkg" ]]; then
    continue
  fi
  sudo pacman -S --noconfirm $pkg
done < $HOME/dotfiles/Pacfile

# install AUR
declare -a aurpkgs=(
  "rbenv"
  "ruby-build"
  "ttf-migu"
  "ttf-ricty"
)
for aurpkg in "${aurpkgs[@]}"; do
  (cd $HOME/dotfiles/submodules/aur/$aurpkg && makepkg -si)
done

eval "$(rbenv init -)"
rbenv install 2.5.1
rbenv global 2.5.1
