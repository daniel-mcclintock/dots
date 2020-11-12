#!/bin/bash

set -ex

packages=(
    base-devel
    bower
    docker
    docker-compose
    fzf
    grunt-cli
    hsetroot
    libxft
    libxinerama
    mariadb-libs
    neovim-git
    nodejs-foreman
    npm
    postgresql-libs
    python
    python-pip
    python-pynvim-git
    qutebrowser
    rbenv
    ruby-build
    ttf-jetbrains-mono
)

python_packages=(
    flake8
    pycodestyle
    pydocstyle
    pylint
    python-language-server
)

if ! yay -Syu --needed --noconfirm ${packages[*]}; then
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

pip install ${python_packages[*]}

ln -sf ${PWD}/bashrc ${HOME}/.bashrc
ln -sf ${PWD}/xinitrc ${HOME}/.xinitrc
ln -sf ${PWD}/bash_profile ${HOME}/.bash_profile
ln -sf ${PWD}/init.vim ${HOME}/.config/nvim/init.vim
ln -sf ${PWD}/dwm/dwm ${HOME}/.local/bin/dwm
ln -sf ${PWD}/st/st ${HOME}/.local/bin/st
ln -sf ${PWD}/work.sh ${HOME}/.local/bin/work
ln -sf ${PWD}/qb-work.sh ${HOME}/.local/bin/qb-work
ln -sf ${PWD}/qb-personal.sh ${HOME}/.local/bin/qb-personal
