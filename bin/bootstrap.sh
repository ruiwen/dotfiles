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

if [ ! `which nvim` ]; then
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt-get update
  sudo apt-get install neovim python-dev python-pip python3-dev python3-pip
  sudo pip3 install neovim
  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
  sudo update-alternatives --config vi
  sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
  sudo update-alternatives --config vim
  sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
  sudo update-alternatives --config editor
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

# Set up symlinks for neovim
if [ `which nvim` ]; then
  NVIM=${HOME}/.config/nvim
  mkdir -p ${NVIM}
  if [ ! -h ${NVIM} ]; then
    ln -s ~/.vim ${NVIM}
  fi
  if [ ! -h ${NVIM}/init.vim ]; then
    ln -s ~/.vimrc ${NVIM}/init.vim
  fi

  for i in undo backup swp; do
    mkdir -p ${NVIM}/.${i}
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
