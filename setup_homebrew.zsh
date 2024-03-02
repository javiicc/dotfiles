#!/usr/bin/zsh

echo "\n<<< Starting Homebrew Setup >>>\n"


if exists brew; then
    echo "brew exists, skipping install"
else
    echo "brew does not exist, continuing with install"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# install and upgrade (by default) all dependencies from the Brewfile
brew bundle --verbose