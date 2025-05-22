#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root"
  exit 1
fi

readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Refreshing pacman keys"
sudo pacman-key --refresh-keys

echo "Refreshing mirrors"
sudo pacman -Sy

sudo pacman -S git \
               tar \
               unzip \
               vim \
               htop \
               curl \
               wget \
               strace \
               ltrace \
               ttf-dejavu \
               gdb \
               base-devel \
               cmake \
               docker \
               openssh \
               nodejs \
               go \
               zsh \
               powerline-fonts \
               kitty \
               deepin-screenshot \
               parcellite \
               fzf \
               screen \
               linux-firmware \
               ntp

echo "Cleaning up cache"
sudo pacman -Sc

# Deploy yay
if ! pacman -Q yay > /dev/null 2>&1; then
    pushd /tmp/
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    popd
    rm -rf /tmp/yay
fi

# Copy dotfiles
echo "Deploying dotfiles"
cp -r ${SCRIPT_DIR}/hostfiles/. ~/

echo "All done!"