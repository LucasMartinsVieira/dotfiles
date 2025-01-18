#!/bin/bash

# INFO: An script for setting up my desktop.

# Variables
BACKUP_DIR="$HOME/.config/backup_config"
SEPARATOR="echo"""

# Colors :
GREEN='\033[0;32m' # Green
BLUE='\033[1;36m'  # Blue
RED='\033[0;31m'   # Red
NC='\033[0m'       # No Color

export NEWT_COLORS="
root=,black
window=,black
shadow=,black
border=blue,black
title=cyan,black
textbox=white,black
radiolist=white,green
label=white,black
checkbox=white,black
actcheckbox=black,blue
compactbutton=white,black
button=black,blue
entry=white,black
actlistbox=white,blue
listbox=white,black"

# Welcome Message.
welcome() {
  echo -e "${BLUE}##########################################################${NC}"
  echo -e "${BLUE}##     Welcome to LucasMartinsVieira install script     ##${NC}"
  echo -e "${BLUE}##               Press enter to continue                ##${NC}"
  echo -e "${BLUE}##         https://github.com/lucasmartinsvieira        ##${NC}"
  echo -e "${BLUE}##########################################################${NC}"
}

# Checking if the cloned repo is in: $HOME/repos/dotfiles/
check_folder() {
  if ! [ -d "$HOME/repos/dotfiles/" ]; then
    echo -e "${RED}For this script work properly you need run him from $HOME/repos/dotfiles/${NC}"
    $SEPARATOR
    echo -e "${BLUE}assuming you've cloned the repository to $HOME:${NC}"
    echo -e "${BLUE}Run these commands:${NC}"
    echo -e "${GREEN}mkdir -p ~/repos${NC}"
    echo -e "${GREEN}mv ~/dotfiles ~/repos${NC}"
    $SEPARATOR
    echo -e "${BLUE}For the config of AwesomeWM work properly you need to clone the submodules${NC}"
    echo -e "${GREEN}git clone --recurse-submodules https://github.com/LucasMartinsVieira/dotfiles.git ~/repos/dotfiles/${NC}"
    exit 0
  fi
}

explanation() {
  echo -e "${GREEN}############################################${NC}"
  echo -e "${GREEN}## Installing 'whiptail' if not installed ##${NC}"
  echo -e "${GREEN}############################################${NC}"
  doas pacman -S libnewt --needed --noconfirm
}

beginning() {
  whiptail --title "Installing Packages!" --msgbox "Installing essential packages (you can see them in 'pkgs.txt') and after them you will have the option of installing optinal packages" 15 60
}

# Installing packages that are listed in pkgs.txt (installing with paru)
packages() {
  echo -e "${BLUE}Installing Packages From pkgs.txt With Paru${NC}"
  cat pkgs.conf | grep -v '^#' | grep -v '^$' >pkgs_no_comments.txt
  paru --needed --ask 4 -Sy - <pkgs_no_comments.txt
  rm pkgs_no_comments.txt
  paru -S --noconfirm --needed librewolf-bin awesome-git
}

# Creating Symbolic Links from the repo folder to $HOME/.local/bin/
scripts() {
  SCRIPTS_FOLDER=$(find $HOME/repos/dotfiles/bin/ -maxdepth 1 -type f | grep -v "README.md" | sed "s#$HOME/repos/dotfiles/bin/##g" | sort)

  if (whiptail --title "Bash Scripts" --yesno "Do you want my bash scripts?" 8 78); then
    for key in $SCRIPTS_FOLDER; do
      mkdir -p ~/.local/bin/
      ln -s ~/repos/dotfiles/bin/$key ~/.local/bin/$key
    done

    $SEPARATOR
    echo -e "${GREEN}The scripts instalation finished. The scripts are located in $HOME/.local/bin/${NC}"
    $SEPARATOR
  fi
}

# The following 6 functions is for a Whiptail window for creating symbolic links from the repo's folder to ~/.config/
get_programs() {
  CONFIG_DIRS=$(find ~/repos/dotfiles/cfg/ -maxdepth 1 -type d | sed "s#$HOME/repos/dotfiles/cfg/##" | sort)
  CONFIG_FILES=$(find ~/repos/dotfiles/cfg/ -maxdepth 1 -type f | sed "s#$HOME/repos/dotfiles/cfg/##" | sort)
}

link_directories() {
  choices=()
  title="Configs"
  text="Choose the configs you want in your system."
  spacer=$(for i in $(seq 1 38); do echo -n " "; done)

  for key in $CONFIG_DIRS; do
    choices+=("${key}" "${spacer}" "OFF")
  done

  result=$(whiptail --title "$title" \
    --checklist "$text" 20 78 12 \
    "${choices[@]}" \
    3>&2 2>&1 1>&3)

  programs=$(echo $result | sed 's/" /\n/g' | sed 's/"//g')

  for link in $programs; do
    if [ -d "$HOME/.config/$link/" ]; then
      mkdir -p ~/.config/backup_config
      cp -r ~/.config/$link/ ~/.config/backup_config
      rm -rf ~/.config/$link/
      ln -s ~/repos/dotfiles/cfg/$link/ ~/.config/$link
    else
      ln -s ~/repos/dotfiles/cfg/$link/ ~/.config/$link
    fi
  done
}

link_files() {
  choices=()
  title="Configs"
  text="Choose the configs you want in your system."
  spacer=$(for i in $(seq 1 38); do echo -n " "; done)

  for key in $CONFIG_FILES; do
    choices+=("${key}" "${spacer}" "OFF")
  done

  result=$(whiptail --title "$title" \
    --checklist "$text" 20 78 12 \
    "${choices[@]}" \
    3>&2 2>&1 1>&3)

  programs=$(echo $result | sed 's/" /\n/g' | sed 's/"//g')

  for link in $programs; do
    if [ -f "$HOME/.config/$link" ]; then
      mkdir -p ~/.config/backup_config
      cp -r ~/.config/$link ~/.config/backup_config
      rm -rf ~/.config/$link
      ln -s ~/repos/dotfiles/cfg/$link ~/.config/$ln_files
    else
      ln -s ~/repos/dotfiles/cfg/$link ~/.config/$ln_files
    fi
  done
}

# Backup function.
backup() {
  $SEPARATOR
  while true; do
    read -p "Do you want to delete the backup? (y/N)" yn
    case $yn in
    [Yy]*)
      rmbackup
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
}

# Remove backup function
rmbackup() {
  rm -rf $BACKUP_DIR
}

# Checking if was a "backup_config" folder in $HOME/.config
check() {
  if [ -d "$BACKUP_DIR" ]; then
    backup
  fi
}

# Function to change the $USER default shell
change_shell() {
  shells=$(grep -ve "^#" -e "^$" -e "/usr/bin/" /etc/shells)

  choices=()
  title="Choose $USER Default Shell"
  text="Choose a Shell"
  spacer=$(for i in $(seq 1 38); do echo -n " "; done)

  for key in $shells; do
    choices+=("${key}" "${spacer}" "OFF")
  done

  result=$(whiptail --title "$title" \
    --radiolist "$text" 20 78 12 \
    "${choices[@]}" \
    3>&2 2>&1 1>&3 || echo "$USER choose not to change shell")

  programs=$(printf "%s" "$result")

  if ! [ "$programs" == "$USER choose not to change shell" ]; then
    doas chsh "$USER" -s "$result"
  else
    echo "$USER choose not to change his default shell"
  fi
}

# Just a finish messsage
finish() {
  $SEPARATOR
  echo -e "${BLUE}Config files are stored in $HOME/repos/dotfiles/cfg/${NC}"
  echo -e "${BLUE}Scripts are stored in $HOME/repos/dotfiles/bin/${NC}"
  echo -e "${BLUE}If you have installed the scripts. They are located in $HOME/.local/bin/${NC}"
  echo -e "${RED}If you remove the folder '$HOME/repos/dotfiles/' you will loose the Configs and the Scripts${NC}"
  $SEPARATOR
  echo -e "${GREEN}Script finished :)\n${NC}"
}

# Grouping the functions for the whiptail window config files symbolic links
configs() {
  get_programs && link_directories
  get_programs && link_files
}

welcome
read -r
check_folder
explanation
beginning
packages
configs
check
scripts
change_shell
finish
