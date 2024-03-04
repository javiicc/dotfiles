# echo 'Load .zshenv'


export ZDOTDIR="${HOME}"
export XDG_CONFIG_HOME="${HOME}/.config"


function exists {
  command -v $1 >/dev/null 2>&1
}

