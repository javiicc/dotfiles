# Loaded only for interactive shell sessions. It is loaded whenever 
# you open a new terminal window or launch a subshell from a terminal 
# window.

# -------------------------------------------------
# ------------------- VARIABLES -------------------
# -------------------------------------------------
# If ZSH is not defined, use the current script's directory.
[[ -z "$ZSH" ]] && export ZSH="${${(%):-%x}:a:h}"


# history settings
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
export HISTSIZE=50000        # History lines stored in mememory.
export SAVEHIST=50000        # History lines stored on disk.
setopt INC_APPEND_HISTORY    # Immediately append commands to history file.
setopt HIST_IGNORE_ALL_DUPS  # Never add duplicate entries.
setopt HIST_IGNORE_SPACE     # Ignore commands that start with a space.
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blank lines.

# zsh-autosuggestions settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=238"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20


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
  if is_theme "$XDG_CONFIG_HOME/zsh/themes" "$ZSH_THEME"; then
    source "$XDG_CONFIG_HOME/zsh/themes/$ZSH_THEME.zsh-theme"
  else
    echo "theme '$ZSH_THEME' not found"
  fi
fi

# # I want to move this to zprofile but it does not work yet
# export PATH=$PATH:$HOME/bin:/usr/local/bin
# export PATH=$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
# export PATH=$PATH:$HOME/.local/lib/python3.10/site-packages:usr/bin/python


eval "$(/opt/homebrew/bin/brew shellenv)"
# enable zsh-autosuggestions by sourcing the zsh-autosuggestions.zsh script
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# enable zsh-syntax-highlighting by sourcing the zsh-syntax-highlighting.zsh script
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"



# # Created by `pipx` on 2024-03-22 20:38:45
# export PATH="$PATH:/home/javiicc/.local/bin"
# #eval "$(register-python-argcomplete pipx)"

# # Enable tab completion poetry
# fpath+=~/.zfunc
# autoload -Uz compinit && compinit

# fnn: Fast Node Manager
eval "$(fnm env --use-on-cd)"

eval "$(/opt/homebrew/bin/brew shellenv)"
