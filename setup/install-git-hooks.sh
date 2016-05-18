#!/bin/bash

cd ~/dotfiles/submodules/git-hooks
make get
cd $GOPATH/src/github.com/git-hooks/git-hooks
go install
