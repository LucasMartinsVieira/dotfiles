#!/bin/bash

# Variables
aur_helpers=("paru" "yay" "Other" "Dont_Have_One")
separator="echo"""

# Welcome Message.
welcome() {
  echo "##########################################################"
  echo "##     Welcome to LucasMartinsVieira programs script    ##"
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
  $separator
}
explanation

start() {
  echo "##################################################################################"
  echo "##                                                                              ##"
  echo "##    first of all, the script will update the system and install base-devel    ##"
  echo "##                                                                              ##"
  echo "##################################################################################"
  doas pacman -S base-devel --needed
}
start

# Finish message at the end of the script.
finish_msg(){
  echo "########################################################################"
  echo "##    Congratulations, now you may or may not have my programs. :)    ##"
  echo "########################################################################"
}

scripts() {
  while true; do
    read -p "Do you want my Rofi/Bash scripts? (y/N)" yn
    case $yn in
        [Yy]* ) script_yes
                break;;
        [Nn]* ) echo "You choose not to get my Rofi/Bash scripts." \
          && $separator\
          && finish_msg;
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
  $separator
  echo "The scripts instalation finished. The scripts are located in $HOME/.local/bin/"
  $separator
  finish_msg
}


other_aur() {
  read -p "What's your Aur Helper?" anwser && confirmation
}

confirmation() {
  while true; do 
  read -p "$anwser is your aur helper? (Y/n)" custom_aur
  $separator
  case $custom_aur in
    [Yy]* ) $anwser -Syu - < pkgs.txt --needed --noconfim --removemake && change_shell;
      break;;
    [Nn]* ) other_aur; 
      break;;
        * ) $anwser -Syu - < pkgs.txt --needed --noconfirm --removemake&& change_shell;
          break;;
  esac
done
}

change_shell() {
  while true; do
    read -p "Do you want to change your user shell to Fish? (y/N)" shch_fish
    case $shch_fish in
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
# TODO: Instalar o awesome-git a parte por causa das dependencias make

echo "Some of the programs i use is from the AUR, so you need an AUR Helper!"
$separator
select choice in "${aur_helpers[@]}"; do
    case $choice in
         paru | yay)
            $choice -Syu - < pkgs.txt --needed --noconfirm --removemake && change_shell
            break
            ;;
         Other)
           other_aur
            break
            ;;
         Dont_Have_One)
           echo "You need an AUR Helper to run this script. I recomend to you to install either paru or yay."
           $separator
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
