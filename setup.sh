#!/bin/bash

set -ex

packages=(
    base-devel
    blender
    bower
    dmenu
    docker
    docker-compose
    elixir
    flake8
    fzf
    grunt-cli
    hsetroot
    libxft
    libxinerama
    mariadb-libs
    mpv
    neovim-git
    nodejs-foreman
    npm
    pass
    pdfjs
    picom
    postgresql-libs
    pyenv
    python
    python-language-server
    python-pip
    python-pipenv
    python-pre-commit
    python-pycodestyle
    python-pydocstyle
    python-pylint
    python-pynvim
    qutebrowser
    rbenv
    ripgrep
    ruby-build
    ttf-jetbrains-mono
    wget
    xdotool
    xorg-xsetroot
)

if ! yay -Syu --needed --noconfirm ${packages[*]}; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg --install --noconfirm
    cd ..
    rm -Rf yay
    yay -Syu --needed --noconfirm ${packages[*]}
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
ln -sf ${PWD}/xinitrc ${HOME}/.xinitrc
ln -sf ${PWD}/bash_profile ${HOME}/.bash_profile
ln -sf ${PWD}/init.vim ${HOME}/.config/nvim/init.vim
ln -sf ${PWD}/dwm/dwm ${HOME}/.local/bin/dwm
ln -sf ${PWD}/st/st ${HOME}/.local/bin/st
ln -sf ${PWD}/bin/* ${HOME}/.local/bin/

mkdir -p ~/.qb-work/config
mkdir -p ~/.qb-personal/config
ln -sf ${PWD}/qutebrowser.config.py ~/.qb-work/config/config.py
ln -sf ${PWD}/qutebrowser.config.py ~/.qb-personal/config/config.py

ln -sf ${PWD}/bin/* ${HOME}/.local/bin/

if [ "$HOSTNAME" == "flaptop" ]; then
    ln -sf ${PWD}/bin_flaptop/* ${HOME}/.local/bin/
fi

# If using custom branch (https://github.com/qutebrowser/qutebrowser/pull/5317)
# ln -sf ${PWD}/qutebrowser/qutebrowser.py ${HOME}/.local/bin/qutebrowser
