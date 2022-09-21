#!/bin/bash

# Variables
backup_dir="$HOME/.config/backup_config"
separator="echo"""

# Welcome Message
welcome() {
  echo "########################################################"
  echo "#     Welcome to LucasMartinsVieira install script     #"
  echo "#               Press enter to continue                #"
  echo "#         https://github.com/lucasmartinsvieira        #"
  echo "########################################################"
}
welcome

read

# Explanation Message
explanation() {
  echo "############################################################################"
  echo "#     The purpose of this script is to install my personal configs for     #"
  echo "#               AwesomeWM, Fish, Kitty, Lf, Neovim and Rofi                #"
  echo "#                                                                          #"
  echo "#         This script Will make a backup folder with your configs in:      #"
  echo "#                           ~/.config/backup_config                        #"
  echo "############################################################################"
}
explanation

$separator

# Configs
configs() {
  while true; do
    #Awesome
    read -p "Do you want my AwesomeWM config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/awesome/ ~/.config/backup_config; rm -rf ~/.config/awesome; ln -s ~/repos/dotfiles/.config/awesome/ ~/.config/awesome
                break;;
        [Nn]* ) echo "You choose not to get my AwesomeWM config.";
                break;;
        * ) echo "You choose not to get my AwesomeWm config.";
        break;;
    esac
  done
$separator

  # Fish
  while true; do
    read -p "Do you want my Fish config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/fish/ ~/.config/backup_config; rm -rf ~/.config/fish; ln -s ~/repos/dotfiles/.config/fish/ ~/.config/fish
                break;;
        [Nn]* ) echo "You choose not to get my Fish config.";
                break;;
        * ) echo "You choose not to get my Fish config.";
        break;;
    esac
  done
$separator

  # Kitty
  while true; do
    read -p "Do you want my Kitty config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/kitty/ ~/.config/backup_config; rm -rf ~/.config/kitty; ln -s ~/repos/dotfiles/.config/kitty/ ~/.config/kitty
                break;;
        [Nn]* ) echo "You choose not to get my Kitty config.";
                break;;
        * ) echo "You choose not to get my Kitty config.";
        break;;
    esac
  done
$separator

  # LF
  while true; do
    read -p "Do you want my LF config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/lf/ ~/.config/backup_config; rm -rf ~/.config/lf; ln -s ~/repos/dotfiles/.config/lf/ ~/.config/lf
                break;;
        [Nn]* ) echo "You choose not to get my LF config.";
                break;;
        * ) echo "You choose not to get my LF config.";
        break;;
    esac
  done
$separator

  # Neovim
  while true; do
    read -p "Do you want my Neovim config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/nvim/ ~/.config/backup_config; rm -rf ~/.config/nvim; ln -s ~/repos/dotfiles/.config/nvim/ ~/.config/nvim
                break;;
        [Nn]* ) echo "You choose not to get my Neovim config.";
                break;;
        * ) echo "You choose not to get my Neovim config.";
        break;;
    esac
  done
$separator

  # Rofi
  while true; do
    read -p "Do you want my Rofi config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/rofi/ ~/.config/backup_config; rm -rf ~/.config/rofi; ln -s ~/repos/dotfiles/.config/rofi/ ~/.config/rofi
                break;;
        [Nn]* ) echo "You choose not to get my Rofi config.";
                break;;
        * ) echo "You choose not to get my Rofi config.";
        break;;
    esac
  done
}
configs

# Backup function
backup() {
$separator
  while true; do
    read -p "Do you want to delete the backup? (y/N)" yn
    case $yn in
      [Yy]* ) rmbackup;
                break;;
        [Nn]* ) echo "You choose not to delete the backup.";
                break;;
        * ) echo "You choose not to delete the backup.";
        break;;
    esac
  done
}

# Remove backup function
rmbackup() {
  rm -rf $backup_dir
}

# Checking if was a "backup_config" folder in $HOME/.config
check(){
  if [ -d "$backup_dir" ]; then
    backup
  fi
}

check
