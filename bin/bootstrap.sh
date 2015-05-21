#!/bin/bash

cd ~
if [ ! `which git` ]; then
  sudo apt-get install -y git
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

for f in pythonrc tmux.conf bashrc dir_colors gitconfig profile vim vimrc; do
    ln -s dotfiles/.${f} ~/.${f}
done

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

. ~/.profile
. ~/.bashrc
touch ~/.python_history
