#!/bin/bash

function run() {
  if [ -n $DRY_RUN ]; then
    eval $*
  else
    echo "[dry run]" $*
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
echo "Login to GitHub."
wait_enter
run xdg-open https://github.com/login
echo "Login to GitHub."
wait_enter

echo "Generating SSH key pair..."
run ssh-keygen -t rsa

echo "Done. Copying id_rsa.pub to clipboard..."
run "cat ~/.ssh/id_rsa.pub | xclip -sel clip"

echo "Done. Now add your ssh key"
wait_enter
run open https://github.com/settings/ssh

wait_enter

sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable
sudo apt-get install -y python-software-properties software-properties-common
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update

# install rbenv and ruby
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
rbenv install -v 2.3.1
rbenv global 2.3.1

# Install various packages
sudo apt-get install silversearcher-ag
sudo apt-get install golang
sudo apt-get install lua5.2
sudo apt-get install -y tmux=2.0-1~ppa1~t

rake install_unix
rake bundle_up_unix
