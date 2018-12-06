# Remove duplications
typeset -U path cdpath manpath fpath

# path(...): add only if condition(...) is true
#  N: NULL_GLOB option
#  -: follow symlink
#  /: directory

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

