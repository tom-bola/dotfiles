DIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"
ln -s ${DIR}/.vim ~
ln -s ${DIR}/.vimrc ~
ln -s ${DIR}/.tmux ~
ln -s ${DIR}/.tmux.conf ~
ln -s ${DIR}/.bash_aliases ~

mkdir -p ~/.config
ln -s ${DIR}/.config/nvim ~/.config

grep -q '~/.bash_aliases' ~/.bashrc || \
  echo '[ -f ~/.bash_aliases ] && source ~/.bash_aliases' >> ~/.bashrc

# Setup Prezto for zsh

ln -s ${DIR}/prezto "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
