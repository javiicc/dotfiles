# echo 'Load .zshenv'


# export XDG_CONFIG_HOME="${HOME}/.config"
# export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"


function exists {
  command -v $1 >/dev/null 2>&1
}