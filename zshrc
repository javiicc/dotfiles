# echo 'Load .zshrc'

# -------------------------------------------------
# ------------------- VARIABLES -------------------
# -------------------------------------------------
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
alias bbd='brew bundle dump --force --describe'
alias eza='eza -lahF --git'
alias ls='eza -lahF --git'
alias man=batman
alias trail='<<<${(F)path}'


# -------------------------------------------------
# -------------- CUSTOMIZE PROMPT(s) --------------
# -------------------------------------------------
### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

CURRENT_BG='NONE'

# Special Powerline characters

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR=$'\ue0b0'
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# Dir: current working directory
prompt_dir() {
  prompt_segment 006 000 $(basename `pwd`)
}

prompt_head() {
  echo "\r               "  # Clear prevous line
  echo "\r %{%F{32}%}[%64<..<%~%<<]"  # Print Dir.
}


# Context: user@hostname (who am I and where am I)
prompt_context() {
  # prompt_segment 000 088 "%(!.%{%F{yellow}%}.)%n"
  prompt_segment 233 088 "%(!.%{%F{yellow}%}.)%n"
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    prompt_segment 052 195 "(${VIRTUAL_ENV:t:gs/%/%%})"
  fi
}
#007
# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    # dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2>/dev/null) || ref="➦ $(git rev-parse --short HEAD 2>/dev/null)"
    # if [[ -n $dirty ]]; then
    #   prompt_segment yellow black
    # else
    prompt_segment 236 189
    # fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '+'
    zstyle ':vcs_info:*' unstagedstr '-'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}


# # Load colors so we can access $fg and more.
# autoload -U colors && colors

# # Prompt. Using single quotes around the PROMPT is very important, otherwise
# # the git branch will always be empty. Using single quotes delays the
# # evaluation of the prompt. Also PROMPT is an alias to PS1.
# git_prompt() {
#     local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3-)"
#     local branch_truncated="${branch:0:30}"
#     if (( ${#branch} > ${#branch_truncated} )); then
#         branch="${branch_truncated}..."
#     fi

#     [ -n "${branch}" ] && echo " (${branch})"
# }


## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_head
  # prompt_status
  prompt_virtualenv
  prompt_context
  # prompt_dir
  prompt_git
  # prompt_bzr
  # prompt_hg
  prompt_end
}

# allows dynamic evaluation of variables and command substitutions within the prompt
setopt PROMPT_SUBST

# PROMPT='%B%{$fg[green]%}%n %{$fg[blue]%}%~%{$fg[yellow]%}$(git_prompt)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b '
PROMPT='%{$reset_color%}%{%f%b%k%}$(build_prompt) '

# -------------------------------------------------



eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# enable zsh-autosuggestions by sourcing the zsh-autosuggestions.zsh script
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# enable zsh-syntax-highlighting by sourcing the zsh-syntax-highlighting.zsh script
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh