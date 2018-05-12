#!/bin/bash

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)

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

declare -a YAOURT_PKGS=("parcellite" "deepin-screenshot" "ttf-ms-fonts" "sublime")
if pacman -Q yaourt > /dev/null 2>&1; then
     for p in "${YAOURT_PKGS[@]}"
     do
        echo "Using yaourt to install ${p}"
        yaourt --noconfirm ${p}
     done
fi

if pacman -Q zsh > /dev/null 2>&1; then
	chsh -s $(whereis zsh | awk '{print $2}')
fi

echo "Deploying dotfiles"
cp -vfr ${SCRIPT_DIRECTORY}/dotfiles/* ~/

ZSH_RC_ADDITIONALS="[ -f ~/.aliases ] && source ~/.aliases"
if ! grep -q "${ZSH_RC_ADDITIONALS}" ~/.zshrc; then
  echo "${ZSH_RC_ADDITIONALS}" >> ~/.zshrc
fi
