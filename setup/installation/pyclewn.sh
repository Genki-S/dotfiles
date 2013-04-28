#!/bin/sh

set -e

echo "Download pyclewn archive to your home directory (Hit Enter)"
read

atool -x $HOME/pyclewn*.tar.gz
rm pyclewn*.tar.gz
cd pyclewn*

pyclewndir=$HOME/.vimlocalbundles/pyclewn
mkdir -p $pyclewndir
vimdir=$pyclewndir python setup.py install --force --home=$HOME

