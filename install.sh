#!/bin/bash

echo "Refreshing pacman keys"
pacman-key --refresh-keys

echo "Refreshing mirrors"
pacman -Sy

pacman -S xorg-xinit \
          xorg \
          i3 \
          git \
          tar \
          unzip \
          wireshark-gtk \
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
          chromium \
          openssh \
          nodejs \
          go \
          zsh \
          peek \
	  powerline-fonts \
	  termite \
	  pulseaudio \
	  alsa-utils \
	  deepin-screenshot \
	  parcellite

systemctl --user enable pulseaudio
systemctl enable docker.service

readonly YAY_PKGS="\
     ttf-ms-fonts \
     ttf-iosevka \
"

echo "Cleaning up cache"
pacman -Sc

# Deploy yay
if pacman -Q yay > /dev/null 2>&1; then
     pushd /tmp/
     git clone https://aur.archlinux.org/yay.git
     cd yay
     makepkg -si
     popd
     rm -rf /tmp/yay
fi

for pkg in ${YAY_PKGS}; do
     if ! yay -Q ${pkg} > /dev/null 2>&1; then
          yay -S ${pkg}
     fi
done

# Configure zsh
if pacman -Q zsh > /dev/null 2>&1; then
	chsh -s $(whereis zsh | awk '{print $2}')
fi

mkdir -p ~/.wallpapers/
