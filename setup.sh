#!/bin/bash

set -ex

if ! yay -Syu --needed --noconfirm base-devel libxinerama libxft fzf neovim-git python-pynvim-git; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg --install --noconfirm
    cd ..
    rm -Rf yay
fi

if ! git clone git@github.com:daniel-mcclintock/dwm.git; then
    git -C dwm fetch
    cd dwm
    make
    cd ..
fi

if ! git clone git@github.com:daniel-mcclintock/st.git; then
    git -C st fetch
    cd st
    make
    cd ..
fi

mkdir -p ${HOME}/.local/bin
mkdir -p ${HOME}/.config/nvim

ln -sf ${PWD}/bashrc ${HOME}/.bashrc
ln -sf ${PWD}/bash_profile ${HOME}/.bash_profile
ln -sf ${PWD}/init.vim ${HOME}/.config/nvim/init.vim
ln -sf ${PWD}/dwm/dwm ${HOME}/.local/bin/dwm
ln -sf ${PWD}/st/st ${HOME}/.local/bin/st
