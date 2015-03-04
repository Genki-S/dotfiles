#!/bin/bash

echo "THIS IS STILL A WIP SCRIPT!!!"
exit 1

function run() {
  if [ -n $DRY_RUN ]; then
    echo "[dry run]" $*
  else
    eval $*
  fi
}

function run_on_dry() {
  if [ -n $DRY_RUN ]; then
    eval $*
  fi
}

function warn() {
  echo "[warn]" $*
}

function wait_enter() {
  echo "Press [Enter] to continue:"
  read
}

echo "Starting installation of Genki-S's environment..."
echo "Installing xcode tools..."
echo "While waiting, login to GitHub."
wait_enter
run open https://github.com/login
run xcode-select --install

echo "Generating SSH key pair..."
run ssh-keygen -t rsa

echo "Done. Copying id_rsa.pub to clipboard..."
run "cat ~/.ssh/id_rsa.pub | pbcopy"

echo "Done. Now add your ssh key"
wait_enter
run open https://github.com/settings/ssh

wait_enter

echo "Cloning Genki-S/dotfiles..."
run git clone git@github.com:Genki-S/dotfiles.git ~/dotfiles

echo "Done. chdir to dotfiles"
run cd ~/dotfiles

echo "Checking if you are a sudoer..."
run sudo -v
run is_sudoer=$?
run_on_dry is_sudoer=$(sudo -v; echo $?)

if [ $is_sudoer -ne 0 ]; then
  warn "You are not a sudoer... will install homebrew in HOME directory."
  run brew_prefix=$HOME
  run_on_dry brew_prefix=$HOME
else
  run brew_prefix=/usr/local
  run_on_dry brew_prefix=/usr/local
fi

echo "Running rake install task..."
run BREW_PREFIX=$brew_prefix rake install

echo "Installing tmux plugins..."
run $HOME/dotfiles/submodules/tpm/scripts/install_plugins.sh

echo "Downloading solarized colorscheme..."
run curl 'https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/Solarized Dark.itermcolors' > ~/SolarizedDark.itermcolors
echo "Applying solarized..."
run ~/Applications/iTerm.app/Contents/MacOS/iTerm ~/SolarizedDark.itermcolors

echo "Executing final setup task..."
run BREW_PREFIX=$brew_prefix rake bundle_up
