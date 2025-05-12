#!/usr/bin/env bash

# Colors :
GREEN='\033[0;32m' # Green
BLUE='\033[1;36m'  # Blue
RED='\033[0;31m'   # Red
NC='\033[0m'       # No Color
SEPARATOR="echo"""

BACKUP_DIR="$HOME/.config/backup_config"
username="lucas"

welcome() {
  echo -e "${BLUE}##########################################################${NC}"
  echo -e "${BLUE}##     Welcome to LucasMartinsVieira install script     ##${NC}"
  echo -e "${BLUE}##               Press enter to continue                ##${NC}"
  echo -e "${BLUE}##         https://github.com/lucasmartinsvieira        ##${NC}"
  echo -e "${BLUE}##########################################################${NC}"
}

install_paru() {
  echo -e "${GREEN}Installing Aur Helper Paru${NC}"
  git clone https://aur.archlinux.org/paru-bin.git
  cd paru-bin
  makepkg -si
  echo -e "${BLUE}Remove paru-bin directory afterwards${NC}"
  sleep 5
  $SEPARATOR
}

configure_pacman_and_paru() {
  # Pacman config
  sudo sed -i 's/#Color/Color/' /etc/pacman.conf &&
    sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 20/' /etc/pacman.conf &&
    sudo sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf &&
    sudo sed -i '/^ParallelDownloads =/a ILoveCandy' /etc/pacman.conf &&
    sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf &&
    sudo echo -e "${BLUE}Pacman configured${NC}"

  # Paru config
  sudo sed -i 's/\#BottomUp/BottomUp/' /etc/paru.conf &&
    sudo sed -i 's/\#RemoveMake/RemoveMake/' /etc/paru.conf &&
    sudo sed -i 's/\#CleanAfter/CleanAfter/' /etc/paru.conf &&
    sudo sed -i 's/\#\[bin\]/\[bin\]/' /etc/paru.conf &&
    sudo sed -i 's/\#FileManager = vifm/FileManager = yazi/' /etc/paru.conf
  echo -e "${BLUE}Paru configured${NC}"
  $SEPARATOR
}

x11() {
  echo -e "${BLUE}Setting X11 up${NC}"
  # Set X11 keyboard
  localectl set-keymap us-acentos

  # Xinitrc
  head -n -5 /etc/X11/xinit/xinitrc >>/home/$username/.xinitrc
  echo "exec awesome" >>/home/"$username"/.xinitrc
  $SEPARATOR
}

services() {
  echo -e "${BLUE}Setting up Services${NC}"
  sudo pacman -S --needed bluez bluez-utils docker openssh libvirt syncthing

  ENABLED_SYSTEMD="NetworkManager libvirtd sshd bluetooth docker syncthing@$username"

  for system in $ENABLED_SYSTEMD; do
    systemctl enable --now "$system"
  done
  $SEPARATOR
}

update_ssh_config() {
  echo -e "${BLUE}Updating ssh config${NC}"
  sudo sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
  sudo sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
  $SEPARATOR
}

setup_user() {
  echo -e "${BLUE}Setting up user${NC}"
  sudo pacman -Sy --needed fish

  sudo usermod -m -G wheel,audio,video,optical,storage,libvirt -s /bin/fish "$username"
  $SEPARATOR
}

mime_type() {
  echo -e "${BLUE}Updating Mime Types${NC}"

  xdg-mime default imv.desktop image/* image/png image/jpeg image/webp

  xdg-mime default org.pwmt.zathura.desktop application/pdf application/rdf+xml application/rss+xml application/xhtml+xml application/xhtml_xml application/xml

  xdg-mime default mpv.desktop image/gif video/*

  xdg-mime default nvim.desktop text/* text/plain

  xdg-mime default zen.desktop text/html text/xml x-scheme-handler/http x-scheme-handler/https x-scheme-handler/about x-scheme-handler/unknown x-scheme-handler/mailto x-scheme-handler/webcal

  $SEPARATOR
}

gtk_theme() {
  echo -e "${BLUE}Setting GTK theme${NC}"
  gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Purple-Dark"
  gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"

  $SEPARATOR
}

packages() {
  echo -e "${BLUE}Installing Packages From pkgs.txt With Paru${NC}"
  cat pkgs.conf | grep -v '^#' | grep -v '^$' >pkgs_no_comments.txt
  paru --needed --ask 4 -Sy - <pkgs_no_comments.txt
  rm pkgs_no_comments.txt
  paru -S --noconfirm --needed librewolf-bin awesome-git
}

scripts() {
  echo -e "${BLUE}Setting up scripts${NC}"
  SCRIPTS_FOLDER=$(find $HOME/repos/dotfiles/bin/ -maxdepth 1 -type f | grep -v "README.md" | sed "s#$HOME/repos/dotfiles/bin/##g" | sort)

  for key in $SCRIPTS_FOLDER; do
    mkdir -p ~/.local/bin/
    ln -s ~/repos/dotfiles/bin/$key ~/.local/bin/$key
  done

  $SEPARATOR
  echo -e "${GREEN}The scripts instalation finished. The scripts are located in $HOME/.local/bin/${NC}"
  $SEPARATOR
}

link_directories() {
  echo -e "${BLUE}Setting up dotfiles${NC}"
  CONFIG_DIRS=$(find ~/repos/dotfiles/cfg/ -maxdepth 1 -type d | sed "s#$HOME/repos/dotfiles/cfg/##" | sort)

  for link in $CONFIG_DIRS; do
    if [ -d "$HOME/.config/$link/" ]; then
      mkdir -p ~/.config/backup_config
      cp -r ~/.config/$link/ ~/.config/backup_config
      rm -rf ~/.config/$link/
      ln -s ~/repos/dotfiles/cfg/$link/ ~/.config/$link
    else
      ln -s ~/repos/dotfiles/cfg/$link/ ~/.config/$link
    fi
  done

  $SEPARATOR
  while true; do
    read -p "Do you want to delete the backup? (y/N)" yn
    case $yn in
    [Yy]*)
      rm -rf $BACKUP_DIR
      break
      ;;
    [Nn]*)
      echo "You choose not to delete the backup."
      break
      ;;
    *)
      echo "You choose not to delete the backup."
      break
      ;;
    esac
  done
  $SEPARATOR
}

the_end() {
  echo -e "${BLUE}################################${NC}"
  echo -e "${BLUE}##     That's all folks!     ##${NC}"
  echo -e "${BLUE}###############################${NC}"
}

welcome
install_paru
configure_pacman_and_paru
x11
services
update_ssh_config
setup_user
mime_type
gtk_theme
packages
scripts
link_directories
the_end
