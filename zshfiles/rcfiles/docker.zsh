if is_mac; then
  function docker() {
    local st
    st=$(boot2docker status)
    if [ "$st" != "running" ]; then
      boot2docker start
    fi
    if [ -z "$DOCKER_HOST" ]; then
      $(boot2docker shellinit)
    fi
    command docker "$@"
  }
fi
