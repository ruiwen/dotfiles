#!/usr/bin/env bash
set -eo pipefail; [[ $TRACE ]] && set -x

cd ~

# Set locale to UTF8
if [ ! $(locale | grep "LC_ALL=en_US.UTF-8") ]; then
  sudo locale-gen en_US.UTF-8
  cat  <<DEF_LC | sudo tee  /etc/default/locale
LANG="en_US.UTF-8"
LANGUAGE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
MESSAGES="POSIX"
DEF_LC

  sudo dpkg-reconfigure locales
fi

declare -a APPS

if [ ! `which git` ]; then
  APPS+=(git)
fi

if [ ! `which tmux` ]; then
  APPS+=(tmux)
fi

if [ ! -z ${APPS} ]; then
  sudo apt-get update && \
  sudo apt-get install -y ${APPS[@]}
fi

if [ ! `vim --version > /dev/null 2>&1 | grep "+python"` ]; then
  sudo apt-get install -y vim-nox
fi

if [ ! -d ~/dotfiles ]; then
    git clone -o github git@github.com:ruiwen/dotfiles.git ~/dotfiles
fi

if [ -f ~/.profile ]; then
    mv ~/.profile ~/.profile.bak
fi

if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
fi

for f in pythonrc tmux.conf bashrc bash_aliases dir_colors gitconfig profile vim vimrc; do
    if [ ! -e ~/.${f} ]; then
        ln -s dotfiles/.${f} ~/.${f}
    fi
done

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install build libraries for YouCompleteMe
echo "Install build-essential, python-dev, cmake (if you haven't already)"
sudo apt-get install -y build-essential python-dev cmake

# Install vim plugins
vim +PluginInstall +qall

if [ -d ~/.vim/bundle/YouCompleteMe ]; then
    pushd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
    popd
fi

. ~/.profile
. ~/.bashrc
touch ~/.python_history
