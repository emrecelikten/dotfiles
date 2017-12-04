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

brew tap d12frosted/emacs-plus

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
  pt
  emacs-plus
)

echo "Installing core binaries and libraries..."
brew install ${binaries[@]}

brew linkapps

# Cask
apps=(
  alfred        # Spotlight replacement
  java
  dropbox
  appcleaner
  firefox
  iterm2
  vlc
  skype
  deluge
  pycharm
  intellij-idea
  clion
  webstorm
  thunderbird
  mumble
  basictex
  gimp
)

echo "Installing applications using cask..."
brew cask install ${apps[@]}

echo "Installing Scala..."
brew install scala sbt

echo "Linking cask applications to Alfred..."
brew cask alfred link

echo "Installing basic LaTeX packages..."
packages=(
  collection-fontsrecommended
  enumitem
  ucs
  collectbox
  adjustbox
  xcolor
  relsize
  ifoddpage
  algorithm2e
  amsmath
  tree-dvips
)

sudo tlmgr update --self
sudo tlmgr install ${packages[@]}

echo "Linking configs to home folder..."
for file in .*; do [[ -f "$file" ]] && ln -Fis $PWD/$file ~/$file; done

echo "Setting up default git editor..."
git config --global core.editor "vim"
git config --global core.excludesfile ~/.gitignore_global
