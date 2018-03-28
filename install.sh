#!/bin/bash

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)

cp -vfr ${SCRIPT_DIRECTORY}/dotfiles/* ~/

echo "Refreshing pacman keys"
sudo pacman-key --refresh-keys

echo "Refreshing mirrors"
sudo pacman -Sy

echo "Installing packges"
sudo pacman -S --needed i3 rofi \
                    termite \
                    scrot \
                    imagemagick \
                    feh \
                    zsh \
                    git \
                    unzip \
                    unrar \
                    tar \
                    gzip \
                    wireshark-gtk \
                    vim \
                    htop \
                    strace \
                    make \
                    gcc \
                    autoconf \
                    gdb \
                    cmake \
                    docker \
                    chromium \
                    openssh \
                    rsync \
                    sed \
                    the_silver_searcher \
                    tree \
                    wget \
                    nodejs \
                    jq \
                    coreutils

echo "Cleaning up cache"
sudo pacman -Sc

#yaourt --noconfirm parcellite
#yaourt --noconfirm deepin-screenshot
#yaourt --noconfirm ttf-ms-fonts
#yaourt --noconfirm sublime
