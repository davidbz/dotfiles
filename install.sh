#!/bin/bash

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)

cp -vr ${SCRIPT_DIRECTORY}/.config ~/

echo "Refreshing pacman keys"
sudo pacman-key --refresh-keys

echo "Refreshing mirrors"
sudo pacman -Syyu

echo "Installing packges"
sudo pacman -S i3 rofi \
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
                    jq

echo "Cleaning up cache"
sudo pacman -Sc

yaourt --noconfirm parcellite
yaourt --noconfirmdeepin-screenshot
