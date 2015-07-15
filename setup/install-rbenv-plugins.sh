#!/bin/bash

set -x

git clone https://github.com/amatsuda/gem-src.git $RBENV_ROOT/plugins/gem-src || true
git clone https://github.com/sstephenson/rbenv-gem-rehash.git $RBENV_ROOT/plugins/rbenv-gem-rehash || true
git clone https://github.com/sstephenson/rbenv-default-gems.git $RBENV_ROOT/plugins/rbenv-default-gems || true
git clone https://github.com/tpope/rbenv-ctags.git $RBENV_ROOT/plugins/rbenv-ctags || true
cp $HOME/dotfiles/rubyfiles/rbenv/default-gems $RBENV_ROOT/default-gems
