#!/bin/zsh

GIT=$(brew --prefix)/bin/git

cd ~/org
# Remove deleted files
$GIT ls-files --deleted -z | xargs -0 $GIT rm >/dev/null 2>&1
# Add new files
$GIT add . >/dev/null 2>&1

$GIT commit -m "$(date)"
$GIT push origin master
