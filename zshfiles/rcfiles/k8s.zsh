function() { # Setup kubernetes aliases
  alias k='kubectl'

  function() { # Setup "op resource" type aliases
    typeset -A operation_by_alias
    operation_by_alias=(
      g get
      d describe
      del delete
    )

    typeset -A resource_by_alias
    resource_by_alias=(
      p pod
      d deployment
      n node
      s service
    )

    for op_alias in "${(@k)operation_by_alias}"
    do
      local op=${operation_by_alias[$op_alias]}
      alias k${op_alias}="k ${op}"
      for resource_alias in "${(@k)resource_by_alias}"
      do
        local resource=${resource_by_alias[$resource_alias]}
        alias k${op_alias}${resource_alias}="k ${op} ${resource}"
      done
    done
  }

  function() { # Setup other form of aliases
    alias kx='k exec'
    alias kl='k logs'
    alias kr='k run'
    alias kc='k config'
    alias kap='k apply'
    alias kapf='k apply -f'
    alias kdelf='k delete -f'
    alias kat='k attach'
    alias kns='k config set-context --current --namespace'
  }
}

# kubectl exec & get a shell
function kxsh {
  local pod=$1
  local shell=${2:-/bin/bash}
  if [ -z "$pod" ]; then
    >&2 echo "usage: kxsh POD <SHELL>"
  fi
  echo "running: kubectl exec -it $pod -- $shell"
  kubectl exec -it $pod -- $shell
}
