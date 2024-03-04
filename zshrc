# echo 'Load .zshrc'

# -------------------------------------------------
# ------------------- VARIABLES -------------------
# -------------------------------------------------
# If ZSH is not defined, use the current script's directory.
[[ -z "$ZSH" ]] && export ZSH="${${(%):-%x}:a:h}"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/lib/python3.10/site-packages:usr/bin/python:$PATH"

# zsh-autosuggestions
SAVEHIST=5000
HISTFILE=~/.zsh_history
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=238"


# -------------------------------------------------
# ---------------- HANDY FUNCTIONS ----------------
# -------------------------------------------------
function mkcd() {
  mkdir -p "$@" && cd "$_";
}


# -------------------------------------------------
# -------------------- ALIASES --------------------
# -------------------------------------------------
# Load aliases if they exist
[ -f "${XDG_CONFIG_HOME}/zsh/.aliases" ] && . "${XDG_CONFIG_HOME}/zsh/.aliases"
[ -f "${XDG_CONFIG_HOME}/zsh/.aliases.local" ] && . "${XDG_CONFIG_HOME}/zsh/.aliases.local"


# -------------------------------------------------
# --------------------- THEME ---------------------
# -------------------------------------------------
# Load the theme
is_theme() {
  local base_dir=$1
  local name=$2
  builtin test -f $base_dir/$name.zsh-theme
}

ZSH_THEME="javiicc-agnoster"

if [[ -n "$ZSH_THEME" ]]; then
  if is_theme "$ZSH/.config/zsh/themes" "$ZSH_THEME"; then
    source "$ZSH/.config/zsh/themes/$ZSH_THEME.zsh-theme"
  else
    echo "theme '$ZSH_THEME' not found"
  fi
fi


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# enable zsh-autosuggestions by sourcing the zsh-autosuggestions.zsh script
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# enable zsh-syntax-highlighting by sourcing the zsh-syntax-highlighting.zsh script
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh