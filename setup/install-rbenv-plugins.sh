#!/bin/bash

set -x

git clone https://github.com/amatsuda/gem-src.git $RBENV_ROOT/plugins/gem-src || true
git clone https://github.com/sstephenson/rbenv-gem-rehash.git $RBENV_ROOT/plugins/rbenv-gem-rehash || true
git clone https://github.com/sstephenson/rbenv-default-gems.git $RBENV_ROOT/plugins/rbenv-default-gems || true
git clone https://github.com/tpope/gem-ctags $RBENV_ROOT/plugins/gem-ctags || true
git clone https://github.com/tpope/gem-ctags $RBENV_ROOT/plugins/gem-ctags || true
git clone https://github.com/julienXX/terminal-notifier /tmp/terminal-notifier || true
rm -rf $RBENV_ROOT/plugins/terminal-notifier && cp -R /tmp/terminal-notifier/Ruby $RBENV_ROOT/plugins/terminal-notifier && rm -rf /tmp/terminal-notifier
cp $HOME/dotfiles/rubyfiles/rbenv/default-gems $RBENV_ROOT/default-gems
