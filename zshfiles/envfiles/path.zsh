# Remove duplications
typeset -U path cdpath manpath fpath

# path(...): add only if condition(...) is true
#  N: NULL_GLOB option
#  -: follow symlink
#  /: directory

# misc. paths
path=(
  $HOME/dotfiles/bin(N/)
  $HOME/.cargo/bin(N/)
  $path
)

# clean $path
# http://blog.n-z.jp/blog/2013-12-12-zsh-cleanup-path.html
path=(
  # allow directories only (-/)
  # reject world-writable directories (^W)
  ${^path}(N-/^W)
)
