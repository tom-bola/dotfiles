DIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"
ln -s ${DIR}/.vim ~
ln -s ${DIR}/.vimrc ~
ln -s ${DIR}/.tmux.conf ~
ln -s ${DIR}/.bash_aliases ~

mkdir -p ~/.config
ln -s ${DIR}/.config/nvim ~/.config

grep -q '~/.bash_aliases' ~/.bashrc || \
  echo '[ -f ~/.bash_aliases ] && source ~/.bash_aliases' >> ~/.bashrc
