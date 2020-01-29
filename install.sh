#!/bin/bash

echo "Refreshing pacman keys"
pacman-key --refresh-keys

echo "Refreshing mirrors"
pacman -Sy

pacman -S xorg-xinit \
          xorg \
          i3-gaps \
          py3status \
          git \
          tar \
          unzip \
          wireshark-gtk \
          vim \
          htop \
          dconf \
          strace \
	      ltrace \
          gdb \
          base-devel \
          cmake \
          docker \
          chromium \
          openssh \
          wget \
          nodejs \
          coreutils \
          go \
          zsh \
          compton \
          feh \
          gnome-terminal \
          pacman-contrib \
          ttf-font-awesome \
          thunar \
          ripgrep \
          gnu-netcat \
          ttf-inconsolata \
          dnsutils \
          peek

readonly YAY_PKGS="\
     ttf-ms-fonts \
     parcellite \
     deepin-screenshot \
     ida-free \
     ttf-iosevka \
"

echo "Cleaning up cache"
pacman -Sc

# Deploy vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

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

dconf load /org/gnome/terminal/ < gnome_profile.txt

