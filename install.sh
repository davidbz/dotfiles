#!/bin/bash

echo "Refreshing pacman keys"
pacman-key --refresh-keys

echo "Refreshing mirrors"
pacman -Sy

pacman -S xorg-xinit \
          xorg \
          i3-gaps \
          git \
          tar \
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
          wget \
          nodejs \
          coreutils \
          go \
          compton

echo "Cleaning up cache"
pacman -Sc

if pacman -Q yay > /dev/null 2>&1; then
     pushd /tmp/
     git clone https://aur.archlinux.org/yay.git
     cd yay
     makepkg -si
     popd
     rm -rf /tmp/yay
fi

if pacman -Q zsh > /dev/null 2>&1; then
	chsh -s $(whereis zsh | awk '{print $2}')
fi
