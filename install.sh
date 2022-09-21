#!/bin/bash

welcome() {
  echo "########################################################"
  echo "#     Welcome to LucasMartinsVieira install script     #"
  echo "#               Press enter to continue                #"
  echo "#         https://github.com/lucasmartinsvieira        #"
  echo "########################################################"
}
welcome

read

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
  # Neovim
  while true; do
    read -p "Do you want my Neovim config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/nvim/ ~/.config/backup_config; rm -rf ~/.config/nvim; cp -r ~/repos/dotfiles/.config/nvim/ ~/.config/nvim
                break;;
        [Nn]* ) echo "You choose not to get my Neovim config.";
                break;;
        * ) echo "You choose not to get my Neovim config.";
        break;;
    esac
  done
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

backup() {
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

rmbackup() {
  backup_dir="$HOME/.config/backup_config"
  rm -rf $backup_dir
}

check(){
  backup_dir="$HOME/.config/backup_config"
  if [ -d "$backup_dir" ]; then
    backup
  fi
}

check
