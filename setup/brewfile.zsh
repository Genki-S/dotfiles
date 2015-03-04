brew update
brew upgrade

brew tap peco/peco

formulas=(
  tig
  emacs
  zsh
  tmux
  reattach-to-user-namespace
  ctags
  coreutils
  the_silver_searcher
  fasd
  direnv
  ispell
  w3m
  wget
  offlineimap
  gpg
  mu
  gnutls
  hub
  fortune
  cowsay
  go
  automake
  caskroom/cask/brew-cask
)

for f in $formulas; do
  brew install $f
  if [ $? -ne 0 ]; then
    exit 1
  fi
done

# TODO: formulas with options
brew install vim --with-lua

casks=(
  iterm2
  firefox
  google-chrome
  dropbox
  alfred
  google-japanese-ime
  dash
  lastpass
  clipmenu
  karabiner
)

for c in $casks; do
  brew cask install $c
  if [ $? -ne 0 ]; then
    exit 1
  fi
done

brew cask alfred link
