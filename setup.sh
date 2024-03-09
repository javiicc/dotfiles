#!/bin/bash


echo "\n<<< Starting Setup >>>\n"


sudo apt update && sudo apt upgrade -y

sudo apt install libfuse2

sudo apt install curl

sudo apt-get install fonts-powerline


echo "\n<<< Starting Homebrew Setup >>>\n"

# install brew if not exists
if exists brew; then
    echo "brew exists, skipping install"
else
    echo "brew does not exist, continuing with install"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# add linuxbrew to path so brew bundle can be executed
PATH_LINUXBREW='/home/linuxbrew/.linuxbrew/bin'
if [[ "$PATH" != *"$PATH_LINUXBREW"* ]]; then
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# install and upgrade (by default) all dependencies from the Brewfile
brew bundle --verbose



echo "\n<<< Starting ZSH Setup >>>\n"


# Installation unnecessary; it's in the Brewfile


# linux
# https://stackoverflow.com/a/4749368/1341838
if grep -Fxq '/home/linuxbrew/.linuxbrew/bin/zsh' '/etc/shells'; then
    echo '/home/linuxbrew/.linuxbrew/bin/zsh already exists in /etc/shells'
else
    # echo "Enter superuser (sudo) password to edit /etc/shells"
    echo '/home/linuxbrew/.linuxbrew/bin/zsh' | sudo tee -a '/etc/shells' >/dev/null
fi

if [ "$SHELL" = '/usr/local/bin/zsh' ]; then
    echo '$SHELL is already /home/linuxbrew/.linuxbrew/bin/zsh'
else
    echo "Enter user password to change login shell"
    sudo chsh --shell '/home/linuxbrew/.linuxbrew/bin/zsh' "$USER" 
fi

if sh --version | grep -q zsh; then
    echo '/usr/bin/sh already linked to /home/linuxbrew/.linuxbrew/bin/zsh'
else
    echo "Enter superuser (sudo) password to symlink sh to zsh"
    sudo ln -sfv /home/linuxbrew/.linuxbrew/bin/zsh /usr/bin/sh
fi


# # macOS
# # https://stackoverflow.com/a/4749368/1341838
# # https://github.com/eieioxyz/dotfiles_macos/blob/master/setup_zsh.zsh
# if grep -Fxq '/usr/local/bin/zsh' '/etc/shells'; then
#   echo '/usr/local/bin/zsh already exists in /etc/shells'
# else
#   echo "Enter superuser (sudo) password to edit /etc/shells"
#   echo '/usr/local/bin/zsh' | sudo tee -a '/etc/shells' >/dev/null
# fi


# if [ "$SHELL" = '/usr/local/bin/zsh' ]; then
#   echo '$SHELL is already /usr/local/bin/zsh'
# else
#   echo "Enter user password to change login shell"
#   chsh -s '/usr/local/bin/zsh'
# fi


# if sh --version | grep -q zsh; then
#   echo '/private/var/select/sh already linked to /bin/zsh'
# else
#   echo "Enter superuser (sudo) password to symlink sh to zsh"
#   # Looked cute, might delete later, idk
#   sudo ln -sfv /bin/zsh /private/var/select/sh

#   # I'd like for this to work instead.
#   # sudo ln -sfv /usr/local/bin/zsh /private/var/select/sh
# fi


# load terminal settings
dconf load /org/gnome/terminal/ < $HOME/.config/gnome_terminal_settings_backup.txt


# sudo reboot
