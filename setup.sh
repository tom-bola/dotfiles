#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"
ln -s ${DIR}/.vim ~
ln -s ${DIR}/.vimrc ~
ln -s ${DIR}/.tmux ~
ln -s ${DIR}/.tmux.conf ~
ln -s ${DIR}/.bash_aliases ~
ln -s ${DIR}/.zshrc ~
ln -s ${DIR}/.zsh ~

mkdir -p ~/.config
ln -s ${DIR}/.config/nvim ~/.config

grep -q '~/.bash_aliases' ~/.bashrc || \
  echo '[ -f ~/.bash_aliases ] && source ~/.bash_aliases' >> ~/.bashrc

if [[ $(uname) = 'Darwin' ]]; then

  # Install homebrew
  if [[ -f '/usr/local/bin/brew' ]]; then
    brew update
  else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Helper that either upgrades or installs a keg
  vv=$(brew ls --versions)
  function install_or_upgrade {
    echo "Brewing $1..."
    if [[ $vv =~ "$1 " ]]; then
      HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1"
    else
      HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
    fi
  }

  install_or_upgrade neovim
  install_or_upgrade reattach-to-user-namespace
  install_or_upgrade autopep8
  install_or_upgrade flake8
  install_or_upgrade the_silver_searcher
  install_or_upgrade tmux
  install_or_upgrade tree
  install_or_upgrade zsh-completions

  pip3 install -U neovim
  pip3 install -U neovim-remote
fi
