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
  make
  wget
  unzip
  vim
  grep
  screen
  ffmpeg
  sshfs
  tree
  ack
  git
  hub
  scala
  sbt
)

echo "Installing core binaries..."
brew install ${binaries[@]}

# Cask
echo "Installing cask..."
brew install caskroom/cask/brew-cask

brew tap caskroom/versions

apps=(
  alfred        # Spotlight replacement
  java
  dropbox
  appcleaner    
  firefox
  karabiner     # Key remapper
  vagrant
  flash
  iterm2
  sublime-text3
  virtualbox
  flux
  vlc
  nvalt         # Note taking software
  skype
  deluge
  pycharm
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
ln -Fis .zshrc ~/.zshrc
ln -Fis Preferences.sublime-settings "/Users/emre/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"

echo "Setting up default git editor as Sublime..."
git config --global core.editor "subl -n -w"

echo "Running OS X configuration..."
sh osx-setup.sh
