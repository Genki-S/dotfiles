brew update
brew upgrade

brew tap peco/peco

formulas=(
  git-flow
  bzr
  atool
  libtool
  glib
  xapian
  gmime
  hg
  gauche
  highlight
  jq
  jsonpp
  migemogrep
)

for f in $formulas; do
  brew install $f
  if [ $? -ne 0 ]; then
    exit 1
  fi
done


casks=(
  calibre
  libreoffice
  flux
  flash
  evernote
  anki
  crashplan
  skype
  mactex
  mendeley-desktop
  cloudytabs
)

for c in $casks; do
  brew cask install $c
  if [ $? -ne 0 ]; then
    exit 1
  fi
done

brew cask alfred link
