#!/bin/bash

set -ex

packages=(
    base-devel
    bower
    dmenu
    docker
    docker-compose
    elixir
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
    postgresql-libs
    python
    python-pip
    python-pynvim-git
    qutebrowser
    rbenv
    ripgrep
    ruby-build
    ttf-jetbrains-mono
    xorg-xsetroot
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
ln -sf ${PWD}/bin/* ${HOME}/.local/bin/

# If using custom branch (https://github.com/qutebrowser/qutebrowser/pull/5317)
#ln -sf ${PWD}/qutebrowser/qutebrowser.py ${HOME}/.local/bin/qutebrowser
