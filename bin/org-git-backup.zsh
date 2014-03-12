#!/bin/zsh

cd ~/org
# Remove deleted files
git ls-files --deleted -z | xargs -0 git rm >/dev/null 2>&1
# Add new files
git add . >/dev/null 2>&1

git commit -m "$(date)"
git push origin master
