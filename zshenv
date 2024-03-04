# This is loaded universally for all types of shell sessions 
# (interactive or non-interactive, login or non-login). It is 
# the only configuration file that gets loaded for non-interactive 
# and non-login scripts like cron jobs. However, macOS overrides 
# this for PATH settings for interactive shells.
# https://www.freecodecamp.org/news/how-do-zsh-configuration-files-work/#:~:text=zprofile%20file%20(versus%20~%2F.,feel%20of%20the%20interactive%20terminal.


export ZDOTDIR="${HOME}"
export XDG_CONFIG_HOME="${HOME}/.config"
