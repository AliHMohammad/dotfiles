#!/bin/bash
set -e

while getopts igmh flag; do
  case "${flag}" in
  i) install=true ;;
  g) gui=true ;;
  m) gnome=true ;;
  esac
done

# Install packages
distro=$(cat /etc/os-release | grep -w ID | cut -d= -f2)
if [ "$install" ]; then
  if [ "$distro" == "manjaro" ]; then
    sudo pacman-mirrors --geoip && sudo pacman -Syyu --noconfirm
    # Install necessary packages for repositories
    sudo pacman -S --needed --noconfirm - <./.extra/req.pacman
    yay -S --needed --noconfirm - <./.extra/req.aur
  else
    echo "Unsupported distro: $distro"
    exit 1
  fi

  # Install gui packages
  if [ "$gui" ]; then
    if [ "$distro" == "manjaro" ]; then
      echo "Installing GUI aur"
      sudo pacman -S --needed --noconfirm - <./.extra/req.pacman.gui
      yay -S --needed --noconfirm - <./.extra/req.aur.gui
    fi

    if [ "$gnome" ]; then
      echo "Installing gnome extensions and setting up gnome keybindings"
      ./install-gnome.sh
    fi
  fi
fi

# Non distro specific
if [ "$install" ]; then
  # Install ZSH
  echo "Installing zsh"
  ./install-zsh.sh

  echo "Setting up default ufw"
  sudo ufw enable
  sudo ufw default deny incoming
  sudo ufw default allow outgoing

  echo "Installation Complete!"
fi

# Setup dotfiles
cp -TR ./.home ~/

echo "Install Script Complete!"
