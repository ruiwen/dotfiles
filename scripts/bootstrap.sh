#!/usr/bin/env bash
# set -eo pipefail; [[ $TRACE ]] && set -x

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

# Install build libraries
echo "Install build-essential, python-dev, cmake (if you haven't already)"
APPS+=(build-essential python-dev cmake)

if [ ! -z ${APPS} ]; then
  sudo apt-get update && \
  sudo apt-get install -y ${APPS[@]}
fi

if [ ! `which nvim` ]; then
  sudo add-apt-repository ppa:neovim-ppa/unstable &&
  sudo apt-get update &&
  sudo apt-get install neovim python3-jedi python-dev python-pip python3-dev python3-pip &&
  sudo pip3 install -U neovim &&
  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60 &&
  sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 &&
  sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
fi

DOTFILES=${HOME}/dotfiles
if [ ! -d ${DOTFILES} ]; then
    git clone -o github git@github.com:ruiwen/dotfiles.git ${DOTFILES}
fi

if [ -f ~/.profile ]; then
    mv ~/.profile ~/.profile.bak
fi

if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
fi

if [ ! -d ~/.psql_history ]; then
  mkdir ~/.psql_history
fi

if [ ! -f ~/.python_history ]; then
  touch ~/.python_history
fi

for f in pythonrc tmux.conf bashrc bash_aliases dir_colors gitconfig profile vim vimrc psqlrc; do
    if [ ! -e ~/.${f} ]; then
        ln -s ${DOTFILES}/.${f} ~/.${f}
    fi
done

# Set up symlinks for neovim
if [ `which nvim` ]; then
  NVIM=${HOME}/.config/nvim
  mkdir -p ${HOME}/.config
  if [ ! -h ${NVIM} ]; then
    ln -s ~/.vim ${NVIM}
  fi
  if [ ! -h ${NVIM}/init.vim ]; then
    ln -s ~/.vimrc ${NVIM}/init.vim
  fi

  for i in undo backup swp; do
    mkdir -p ${NVIM}/.${i}
  done
fi

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install vim plugins
vim +PlugInstall +qall

# Install tmux plugin manager and bootstrap listed plugins
git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm && \
  ${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh


. ${HOME}/.profile
. ${HOME}/.bashrc
touch ${HOME}/.python_history
