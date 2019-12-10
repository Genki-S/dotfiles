# Remove duplications
typeset -U path cdpath manpath fpath

# path(...): add only if condition(...) is true
#  N: NULL_GLOB option
#  -: follow symlink
#  /: directory

if [ -z "$ANYENV_INITIALIZED" ]; then
  # setup anyenv, this is slow, but has to be done only once (anyenv exports its variables)
  path=(
    $HOME/.anyenv/bin
    $path
  )
  eval "$(anyenv init -)"
  export ANYENV_INITIALIZED="yes"
fi


# misc. paths
path=(
  $HOME/dotfiles/bin(N/)
  $(go env GOPATH)/bin(N/)
  $HOME/.cargo/bin
  $path
)

# clean $path
# http://blog.n-z.jp/blog/2013-12-12-zsh-cleanup-path.html
path=(
  # allow directories only (-/)
  # reject world-writable directories (^W)
  ${^path}(N-/^W)
)
