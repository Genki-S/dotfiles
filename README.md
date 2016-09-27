# Dear me

This is an instruction to set up your brand new Mac.
Have fun :)

# Automatic Installs

## Install essentials

- `rake install`
- open up another shell (which should be zsh)
- `rake bundle_up`

TODO: remove downloads of non-essentials and speed up

## Install vendor applications

```
vim -u ~/dotfiles/vendor/neovendor.vim
```

Installs in `~/vendor`.

# Manual Installations

## Mac Apps

- open App Store
- install purchased Apps

## Firefox Addons

- Vimperator
- Firebug
- dotjs
- Text Link

## Other things

- [moovweb/gvm](https://github.com/moovweb/gvm)
- [brigade/overcommit](https://github.com/brigade/overcommit)
  - Don't forget to update `gitfiles/git_template_dir/hooks` periodically
TODO: Install executables for overcommit config
TODO: Install cargo for Rust packages

# Known issues

- Homebrew cask can't be installed without sudo privilege

# For Ubuntu

WIP

- Install rbenv
- Install ruby
- Install golang
- Install lua
- Build Vim
  - http://unix.stackexchange.com/questions/2807/why-does-my-vim-7-3-compile-fail-to-include-clientserver
  - https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
  - http://superuser.com/questions/660593/how-to-compile-a-gvim-from-source-using-the-latest-version
- Build Emacs
  - sudo apt-get build-dep emacs24
  - wget -O- http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.xz | tar xJf -
  - sudo apt-get install bzr
  - sudo apt-get build-dep mu4e
- sudo apt-get install tig
- sudo apt-get install espeak
- sudo add-apt-repository:
  - ppa:jconti/recent-notifications
- sudo apt-get install:
  - mercurial
  - tree
  - indicator-notifications
  - exuberant-ctags
  - findbugs
  - nodejs
  - npm
- Install fasd https://github.com/clvv/fasd
- Install Fcitx for Japanese input https://blogs.fsfe.org/stefan.a/2014/09/23/set-up-fcitx-chinese-and-japanese-language-input-ubuntu-14-04/
  - Don't use ibus, it's kana-input is messed up
- Install solarized: https://github.com/Anthony25/gnome-terminal-colors-solarized

## Install Mayu (Karabiner alternative for Ubuntu)

Xmodmap cannot be used to map keys with control modifier.

- [Ubuntu 14.04にMozcと窓使いの憂鬱をインストールする - Symfoware](http://symfoware.blog68.fc2.com/blog-entry-1397.html)
- [「のどか」 - KEYBOARD](http://www.appletkan.com/nodoka-doc/keyboard.html)
