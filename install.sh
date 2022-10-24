#!/bin/bash

# Variables
BACKUP_DIR="$HOME/.config/backup_config"
AUR_HELPERS=("paru" "yay" "Other" "Dont_Have_One")
SEPARATOR="echo"""

# Welcome Message.
welcome() {
  echo "##########################################################"
  echo "##     Welcome to LucasMartinsVieira install script     ##"
  echo "##               Press enter to continue                ##"
  echo "##         https://github.com/lucasmartinsvieira        ##"
  echo "##########################################################"
}
welcome

read

# Explanation Message
explanation() {
  echo "##################################################################################"
  echo "##   the purpose of this script is to install programs that i use for example   ##"
  echo "##                                                                              ##"
  echo "##          Alacritty ,AwesomeWM, Fish, Kitty, Lf, Neovim, Rofi, etc.           ##"
  echo "##                          And my Rofi/Bash Scripts                            ##"
  echo "##                                                                              ##"
  echo "##################################################################################"
  $SEPARATOR
}
explanation

start() {
  echo "############################################################"
  echo "##                                                        ##"
  echo "##    first of all, the script will install base-devel    ##"
  echo "##                                                        ##"
  echo "############################################################"
  doas pacman -S base-devel --needed
}
start

finish_msg(){
  echo "########################################################################"
  echo "##    Congratulations, now you may or may not have my programs. :)    ##"
  echo "########################################################################"
}

configs() {
  while true; do
    # Alacritty
    read -p "Do you want my Alacritty config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/alacritty/ ~/.config/backup_config; \
          rm -rf ~/.config/alacritty; ln -s ~/repos/dotfiles/.config/alacritty/ ~/.config/alacritty
                break;;
        [Nn]* ) echo "You choose not to get my Alacritty config.";
                break;;
        * ) echo "You choose not to get my Alacritty config.";
        break;;
    esac
  done
$SEPARATOR

  while true; do
    #Awesome
    read -p "Do you want my AwesomeWM config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/awesome/ ~/.config/backup_config; \
          rm -rf ~/.config/awesome; ln -s ~/repos/dotfiles/.config/awesome/ ~/.config/awesome
                break;;
        [Nn]* ) echo "You choose not to get my AwesomeWM config.";
                break;;
        * ) echo "You choose not to get my AwesomeWm config.";
        break;;
    esac
  done
$SEPARATOR

  # Fish
  while true; do
    read -p "Do you want my Fish config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/fish/ ~/.config/backup_config; \
          rm -rf ~/.config/fish; ln -s ~/repos/dotfiles/.config/fish/ ~/.config/fish
                break;;
        [Nn]* ) echo "You choose not to get my Fish config.";
                break;;
        * ) echo "You choose not to get my Fish config.";
        break;;
    esac
  done
$SEPARATOR

  # Kitty
  while true; do
    read -p "Do you want my Kitty config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/kitty/ ~/.config/backup_config; \
          rm -rf ~/.config/kitty; ln -s ~/repos/dotfiles/.config/kitty/ ~/.config/kitty
                break;;
        [Nn]* ) echo "You choose not to get my Kitty config.";
                break;;
        * ) echo "You choose not to get my Kitty config.";
        break;;
    esac
  done
$SEPARATOR

  # LF
  while true; do
    read -p "Do you want my LF config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/lf/ ~/.config/backup_config; rm -rf ~/.config/lf; \
          ln -s ~/repos/dotfiles/.config/lf/ ~/.config/lf; cp -r ~/.config/lf-ueberzug/ ~/.config/backup_config; rm -rf ~/.config/lf-ueberzug; \
          ln -s ~/repos/dotfiles/.config/lf-ueberzug/ ~/.config/lf-ueberzug
                break;;
        [Nn]* ) echo "You choose not to get my LF config.";
                break;;
        * ) echo "You choose not to get my LF config.";
        break;;
    esac
  done
$SEPARATOR

  # Neovim
  while true; do
    read -p "Do you want my Neovim config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/nvim/ ~/.config/backup_config; \
          rm -rf ~/.config/nvim; ln -s ~/repos/dotfiles/.config/nvim/ ~/.config/nvim
                break;;
        [Nn]* ) echo "You choose not to get my Neovim config.";
                break;;
        * ) echo "You choose not to get my Neovim config.";
        break;;
    esac
  done
$SEPARATOR

  # Rofi
  while true; do
    read -p "Do you want my Rofi config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/rofi/ ~/.config/backup_config; \
          rm -rf ~/.config/rofi; ln -s ~/repos/dotfiles/.config/rofi/ ~/.config/rofi
                break;;
        [Nn]* ) echo "You choose not to get my Rofi config.";
                break;;
        * ) echo "You choose not to get my Rofi config.";
        break;;
    esac
  done
  check
}

# Backup function.
backup() {
$SEPARATOR
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
  rm -rf $BACKUP_DIR
}

# Checking if was a "backup_config" folder in $HOME/.config
check(){
  if [ -d "$BACKUP_DIR" ]; then
    backup
  else
    finish_msg
  fi
}

$SEPARATOR
scripts() {
  while true; do
    read -p "Do you want my Rofi/Bash scripts? (y/N)" yn
    case $yn in
        [Yy]* ) script_yes
                break;;
        [Nn]* ) echo "You choose not to get my Rofi/Bash scripts." \
          && $SEPARATOR\
          && configs;
                break;;
        * ) echo "You choose not to get my Rofi/Bash scripts.";
        break;;
    esac
  done
}

script_yes() {
  mkdir -p $HOME/repos/
  cd $HOME/repos/
  git clone git@github.com:LucasMartinsVieira/scripts.git
  cd $HOME/repos/scripts
  cp lfrun ~/.local/bin/
  ln -s ~/repos/scripts/arch-checkupdates ~/.local/bin/arch-checkupdates
  ln -s ~/repos/scripts/rofi-bangs ~/.local/bin/rofi-bangs
  ln -s ~/repos/scripts/rofi-beats ~/.local/bin/rofi-beats
  ln -s ~/repos/scripts/rofi-colorscheme ~/.local/bin/rofi-colorscheme
  ln -s ~/repos/scripts/rofi-files ~/.local/bin/rofi-files
  ln -s ~/repos/scripts/rofi-maim ~/.local/bin/rofi-maim
  ln -s ~/repos/scripts/rofi-powermenu ~/.local/bin/rofi-powermenu
  ln -s ~/repos/scripts/rofi-search ~/.local/bin/rofi-search
  ln -s ~/repos/scripts/rofi-wallpaper ~/.local/bin/rofi-wallpaper
  $SEPARATOR
  echo "The scripts instalation finished. The scripts are located in $HOME/.local/bin/"
  $SEPARATOR
  configs
}

other_aur() {
  read -p "What's your Aur Helper?" anwser && confirmation
}

confirmation() {
  while true; do 
  read -p "$anwser is your aur helper? (Y/n)" custom_aur
  $SEPARATOR
  case $custom_aur in
    [Yy]* ) $anwser -Syu - < pkgs.txt --needed --noconfim --askremovemake && change_shell;
      break;;
    [Nn]* ) other_aur; 
      break;;
        * ) $anwser -Syu - < pkgs.txt --needed --noconfirm --askremovemake && change_shell;
          break;;
  esac
done
}

change_shell() {
  while true; do
    read -p "Do you want to change your user shell to Fish? (y/N)" chsh_fish
    case $chsh_fish in
        [Yy]* ) chsh -s /bin/fish && scripts
                break;;
        [Nn]* ) echo "You choose not to change your user shell." && scripts; 
                break;;
        * ) echo "You choose not to change your user shell." && scripts;
        break;;
    esac
  done
}

main() {
select choice in "${AUR_HELPERS[@]}"; do
    case $choice in
         paru | yay)
            $choice -Syu - < pkgs.txt --needed --noconfirm --askremovemake && change_shell
            break
            ;;
         Other)
           other_aur
            break
            ;;
         Dont_Have_One)
           echo "You need an AUR Helper to run this script. I recomend to you to install either paru or yay."
           $SEPARATOR
           echo "Paru"
           echo "https://github.com/Morganamilo/paru"
           echo "Yay"
           echo "https://github.com/Jguer/yay"
           break
            ;;
         *)
              echo "invalid option $REPLY"
            ;;
    esac
done
}
main
