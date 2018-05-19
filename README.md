# Genki's dotfiles

## Automatic Installs

### Install essentials

- `rake install`
- open up another shell (which should be zsh)
- `rake bundle_up`

TODO: remove downloads of non-essentials and speed up

### Install vendor applications

```
vim -u ~/dotfiles/vendor/neovendor.vim
```

Installs in `~/vendor`.

## Manual Installations

### Mac Apps

- open App Store
- install purchased Apps

### Firefox Addons

- Vimperator
- Firebug
- dotjs
- Text Link

### TODO: To be automated

- [moovweb/gvm](https://github.com/moovweb/gvm)
- [brigade/overcommit](https://github.com/brigade/overcommit)
- Install executables for overcommit config
- Install cargo for Rust packages
- [Go, Ruby, PythonでGNU GLOBAL(gtags)+α - Qiita](http://qiita.com/sona-tar/items/672df1259a76f082ce42)
- Install [tinytacoteam/zazu](https://github.com/tinytacoteam/zazu)

## Known issues

- Homebrew cask can't be installed without sudo privilege

## For Arch

Run `./install_arch.sh` and cross your fingers.

## For Ubuntu

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
- Make `Super-<Tab>` change windows: [shortcut keys - Sane alt-tab behaviour in Ubuntu 14.04.1 (unity) - Ask Ubuntu](http://askubuntu.com/questions/543148/sane-alt-tab-behaviour-in-ubuntu-14-04-1-unity)
- Install [jhawthorn/fzy: A better fuzzy finder](https://github.com/jhawthorn/fzy)

### Install Mayu (Karabiner alternative for Ubuntu)

Xmodmap cannot be used to map keys with control modifier.

- [Ubuntu 14.04にMozcと窓使いの憂鬱をインストールする - Symfoware](http://symfoware.blog68.fc2.com/blog-entry-1397.html)
- [「のどか」 - KEYBOARD](http://www.appletkan.com/nodoka-doc/keyboard.html)
