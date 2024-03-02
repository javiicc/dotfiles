# echo 'Load .zshrc'

# -------------------------------------------------
# ------------------- VARIABLES -------------------
# -------------------------------------------------
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/lib/python3.10/site-packages:usr/bin/python:$PATH"

# zsh-autosuggestions
SAVEHIST=1000
HISTFILE=~/.zsh_history
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   git
#   zsh-syntax-highlighting
#   zsh-autosuggestions
#   poetry
# )


# source $ZSH/oh-my-zsh.sh


# -------------------------------------------------
# ---------------- HANDY FUNCTIONS ----------------
# -------------------------------------------------
function mkcd() {
  mkdir -p "$@" && cd "$_";
}


# -------------------------------------------------
# -------------------- ALIASES --------------------
# -------------------------------------------------
alias bbd='brew bundle dump --force --describe'
alias eza='eza -lahF --git'
alias ls='eza -lahF --git'
alias man=batman
alias trail='<<<${(F)path}'


# -------------------------------------------------
# -------------- CUSTOMIZE PROMPT(s) --------------
# -------------------------------------------------


# -------------------------------------------------



eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# enable zsh-autosuggestions by sourcing the zsh-autosuggestions.zsh script
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# enable zsh-syntax-highlighting by sourcing the zsh-syntax-highlighting.zsh script
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh