#!/bin/bash

SCRIPT_DIRECTORY=$(cd `dirname $0` && pwd)

echo "Refreshing pacman keys"
sudo pacman-key --refresh-keys

echo "Refreshing mirrors"
sudo pacman -Sy

echo "Installing packges"
sudo pacman -S --needed zsh \
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
                    tree \
                    wget \
                    nodejs \
                    jq \
                    coreutils

echo "Cleaning up cache"
sudo pacman -Sc

pushd /tmp/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
popd

if pacman -Q zsh > /dev/null 2>&1; then
	chsh -s $(whereis zsh | awk '{print $2}')
fi

ZSH_RC_ADDITIONALS="[ -f ~/.aliases ] && source ~/.aliases"
if ! grep -q "${ZSH_RC_ADDITIONALS}" ~/.zshrc; then
  echo "${ZSH_RC_ADDITIONALS}" >> ~/.zshrc
fi
