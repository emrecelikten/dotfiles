#!/usr/bin/env bash

# Based on http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
echo "Installing coreutils..."
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

brew tap homebrew/dupes

# Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh

binaries=(
  wget
  vim
  grep
  tmux
  ffmpeg
  sshfs
  tree
  ack
  git
)

echo "Installing core binaries and libraries..."
brew install ${binaries[@]}

# Cask
apps=(
  alfred        # Spotlight replacement
  java
  dropbox
  appcleaner    
  firefox
  karabiner     # Key remapper
  iterm2
  visual-studio-code
  vlc
  nvalt         # Note taking software
  skype
  deluge
  pycharm
  intellij-idea
  clion
  thunderbird
  mumble
  mactex
  gimp
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing applications using cask..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Linking cask applications to Alfred..."
brew cask alfred link

echo "Linking configs to home folder..."
for file in .*; do [[ -f "$file" ]] && ln -Fis $PWD/$file ~/$file; done

echo "Setting up default git editor as Sublime..."
git config --global core.editor "code --wait"

echo "Running OS X configuration..."
sh osx-setup.sh
