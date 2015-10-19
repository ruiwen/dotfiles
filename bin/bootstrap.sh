#!/bin/bash

cd ~
if [ ! `which git` ]; then
  sudo apt-get install -y git
fi

if [ ! `which tmux` ]; then
  sudo apt-get install -y tmux
fi

if [ ! -d ~/dotfiles ]; then
    git clone https://github.com/ruiwen/dotfiles.git
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
    ./install.py --clang-completer --gocode-completer
    popd
fi

. ~/.profile
. ~/.bashrc
touch ~/.python_history
