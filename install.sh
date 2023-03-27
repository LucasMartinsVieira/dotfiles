#!/bin/bash

# Variables
BACKUP_DIR="$HOME/.config/backup_config"
AUR_HELPERS=("paru" "yay" "Neither_of_them")
SEPARATOR="echo"""

# Colors :
GREEN='\033[0;32m'        # Green
BLUE='\033[1;36m'         # Blue
RED='\033[0;31m'          # Red
NC='\033[0m'              # No Color


export NEWT_COLORS="
root=,blue
window=,black
shadow=,blue
border=blue,black
title=blue,black
textbox=blue,black
radiolist=black,black
label=black,blue
checkbox=black,blue
compactbutton=black,blue
button=black,red"

# Welcome Message.
welcome() {
  echo -e "${BLUE}##########################################################${NC}"
  echo -e "${BLUE}##     Welcome to LucasMartinsVieira install script     ##${NC}"
  echo -e "${BLUE}##               Press enter to continue                ##${NC}"
  echo -e "${BLUE}##         https://github.com/lucasmartinsvieira        ##${NC}"
  echo -e "${BLUE}##########################################################${NC}"
}
welcome

read

explanation() {
   echo -e "${GREEN}#############################################################${NC}"
   echo -e "${GREEN}## Installing 'whiptail' and 'base-devel' if not installed ##${NC}"
   echo -e "${GREEN}#############################################################${NC}"
   doas pacman -S base-devel libnewt --needed --noconfirm
}

explanation

beginning() {
   whiptail --title "Installing Packages!" --msgbox "Installing essential packages (you can see them in 'pkgs.txt') and after them you will have the option of installing optinal packages" 15 60
}

beginning

aur_helper() {
select choice in "${AUR_HELPERS[@]}"; do
    case $choice in
        paru)
            $choice -Syu - < pkgs.txt --needed --noconfirm && scripts
            break
            ;;
        yay)
            $choice -Syu - < pkgs.txt --needed --noconfirm && scripts
            break
            ;;
        Neither_of_them)
           echo "You need an AUR Helper to run this script. Install either paru or yay."
           $SEPARATOR
           echo "Paru"
           echo "https://github.com/Morganamilo/paru"
           echo "Yay"
           echo "https://github.com/Jguer/yay"
           exit 1
            ;;
         *)
           echo "invalid option $REPLY"
            ;;
    esac
done
}

aur_helper

optinal_packages() {
  whiptail --title "Optinal Packages!" --msgbox "Now you will have the option to installing optional packages" 15 60
}

optinal_packages

max() {
    echo -e "$1\n$2" | sort -n | tail -1
}

getbiggestword() {
    echo "$@" | sed "s/ /\n/g" | wc -L
}

replicate() {
    local n="$1"
    local x="$2"
    local str

    for _ in $(seq 1 "$n"); do
        str="$str$x"
    done
    echo "$str"
}

programchoices() {
    choices=()
    local maxlen; maxlen="$(getbiggestword "${!checkboxes[@]}")"
    linesize="$(max "$maxlen" 42)"
    local spacer; spacer="$(replicate "$((linesize - maxlen))" " ")"

    for key in "${!checkboxes[@]}"
    do
        # A portable way to check if a command exists in $PATH and is executable.
        # If it doesn't exist, we set the tick box to OFF.
        # If it exists, then we set the tick box to ON.
        if ! command -v "${checkboxes[$key]}" > /dev/null; then
            # $spacer length is defined in the individual window functions based
            # on the needed length to make the checkbox wide enough to fit window.
            choices+=("${key}" "${spacer}" "OFF")
        else
            choices+=("${key}" "${spacer}" "ON")
        fi
    done
}

selectedprograms() {
    result=$(
        # Creates the whiptail checklist. Also, we use a nifty
        # trick to swap stdout and stderr.
        whiptail --title "$title"                               \
                 --checklist "$text" 22 "$((linesize + 16))" 12 \
                 "${choices[@]}"                                \
                 3>&2 2>&1 1>&3
    )
}

exitorinstall() {
    local exitstatus="$?"
    # Check the exit status, if 0 we will install the selected
    # packages. A command which exits with zero (0) has succeeded.
    # A non-zero (1-255) exit status indicates failure.
    if [ "$exitstatus" = 0 ]; then
        # Take the results and remove the "'s and add new lines.
        # Otherwise, pacman is not going to like how we feed it.
        programs=$(echo "$result" | sed 's/" /\n/g' | sed 's/"//g')
        echo "$programs"
        $choice --needed --noconfirm  -S "$programs" || \
        echo "Failed to install required packages."
    else
        echo "User selected Cancel."
    fi
}

browsers() {
    local title="Web Browsers"
    local text="Select one or more web browsers to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them."

    # Create an array with KEY/VALUE pairs.
    # The first ["KEY] is the name of the package to install.
    # The second ="VALUE" is the executable binary.
    local -A checkboxes
    checkboxes["brave-bin"]="brave"
    checkboxes["chromium"]="chromium"
    checkboxes["firefox"]="firefox"
    checkboxes["librewolf-bin"]="librewolf"
    checkboxes["qutebrowser"]="qutebrowser"
    checkboxes["ungoogled-chromium-bin"]="ungoogled-chromium"
    checkboxes["luakit"]="luakit"

    programchoices && selectedprograms && exitorinstall
}

devstuff() {
    local title="Development Programs"
    local text="Development programs available for installation.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them."

    # Create an array with KEY/VALUE pairs.
    # The first ["KEY] is the name of the package to install.
    # The second ="VALUE" is the executable binary.
    local -A checkboxes
    checkboxes["deno"]="deno"
    checkboxes["docker"]="docker"
    checkboxes["docker-compose"]="docker-compose"
    checkboxes["nodejs"]="node"
    checkboxes["npm"]="npm"
    checkboxes["lazygit"]="lazygit"
    checkboxes["prettier"]="prettier"
    checkboxes["stylua"]="stylua"
    checkboxes["shellcheck"]="shellcheck"
    checkboxes["rust-analyzer"]="rust-analyzer"

    programchoices && selectedprograms && exitorinstall
}

internet() {
    local title="Internet Related Programs"
    local text="Internet related programs available for installation.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them."

    # Create an array with KEY/VALUE pairs.
    # The first ["KEY] is the name of the package to install.
    # The second ="VALUE" is the executable binary.
    local -A checkboxes
    checkboxes["ani-cli"]="ani-cli"
    checkboxes["geary"]="geary"
    checkboxes["telegram-desktop"]="telegram"
    checkboxes["thunderbird"]="thunderbird"
    checkboxes["mailspring"]="mailspring"
    checkboxes["mangal-bin"]="mangal"
    checkboxes["transmission-gtk"]="transmission"
    checkboxes["transmission-gtk"]="transmission"
    checkboxes["spotify"]="spotify"
    checkboxes["discord"]="discord"

    programchoices && selectedprograms && exitorinstall
}

games() {
    local title="Games"
    local text="Gaming programs available for installation.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them."

    # Create an array with KEY/VALUE pairs.
    # The first ["KEY] is the name of the package to install.
    # The second ="VALUE" is the executable binary.
    local -A checkboxes
    checkboxes["steam"]="steam"
    checkboxes["gnuchess"]="gnuchess"
    checkboxes["lutris"]="lutris"
    checkboxes["heroic-games-launcher-bin"]="heroic-games-launcher"

    programchoices && selectedprograms && exitorinstall
}

browsers
devstuff
internet
games

scripts() {
  if (whiptail --title "Scripts" --yesno "Do you want my rofi/bash scripts?" 15 60); then
    script_yes
  else
    change_shell
  fi
}

script_yes() {
  mkdir -p $HOME/repos/
  # cd $HOME/repos/dotfiles/
  cp ~/repos/dotfiles/bin/lfrun ~/.local/bin/
  ln -s ~/repos/dotfiles/bin/colorscheme ~/.local/bin/colorscheme
  ln -s ~/repos/dotfiles/bin/files ~/.local/bin/files
  ln -s ~/repos/dotfiles/bin/search ~/.local/bin/search
  ln -s ~/repos/dotfiles/bin/usb ~/.local/bin/usb
  ln -s ~/repos/dotfiles/bin/cht ~/.local/bin/cht
  ln -s ~/repos/dotfiles/bin/wallpaper ~/.local/bin/wallpaper
  ln -s ~/repos/dotfiles/bin/aw ~/.local/bin/aw
  ln -s ~/repos/dotfiles/bin/bookmark ~/.local/bin/bookmark
  $SEPARATOR
  echo -e "${GREEN}The scripts instalation finished. The scripts are located in $HOME/.local/bin/${NC}"
  $SEPARATOR
  change_shell
}
configs() {
  while true; do
    #Awesome
    read -p "Do you want my alacritty config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/alacritty/ ~/.config/backup_config; \
          rm -rf ~/.config/alacritty; ln -s ~/repos/dotfiles/cfg/alacritty/ ~/.config/alacritty
                break;;
        [Nn]* ) echo "You choose not to get my alacritty config.";
                break;;
        * ) echo "You choose not to get my alacritty config.";
        break;;
    esac
  done
$SEPARATOR

  while true; do
    #Awesome
    read -p "Do you want my AwesomeWM config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/awesome/ ~/.config/backup_config; \
          rm -rf ~/.config/awesome; ln -s ~/repos/dotfiles/cfg/awesome/ ~/.config/awesome
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
          rm -rf ~/.config/fish; ln -s ~/repos/dotfiles/cfg/fish/ ~/.config/fish
                break;;
        [Nn]* ) echo "You choose not to get my Fish config.";
                break;;
        * ) echo "You choose not to get my Fish config.";
        break;;
    esac
  done
$SEPARATOR

  # Starship
  while true; do
    read -p "Do you want my Starship config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp ~/.config/starship.toml ~/.config/backup_config; \
          rm -rf ~/.config/starship.toml; ln -s ~/repos/dotfiles/cfg/starship.toml ~/.config/starship.toml
                break;;
        [Nn]* ) echo "You choose not to get my Starship config.";
                break;;
        * ) echo "You choose not to get my Starship config.";
        break;;
    esac
  done
$SEPARATOR
  # Kitty
  while true; do
    read -p "Do you want my Kitty config? (y/N)" yn
    case $yn in
        [Yy]* ) mkdir -p ~/.config/backup_config; cp -r ~/.config/kitty/ ~/.config/backup_config; \
          rm -rf ~/.config/kitty; ln -s ~/repos/dotfiles/cfg/kitty/ ~/.config/kitty
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
          ln -s ~/repos/dotfiles/cfg/lf/ ~/.config/lf; cp -r ~/.config/lf-ueberzug/ ~/.config/backup_config; rm -rf ~/.config/lf-ueberzug; \
          ln -s ~/repos/dotfiles/cfg/lf-ueberzug/ ~/.config/lf-ueberzug
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
          rm -rf ~/.config/nvim; ln -s ~/repos/dotfiles/cfg/nvim/ ~/.config/nvim
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
          rm -rf ~/.config/rofi; ln -s ~/repos/dotfiles/cfg/rofi/ ~/.config/rofi
                break;;
        [Nn]* ) echo "You choose not to get my Rofi config.";
                break;;
        * ) echo "You choose not to get my Rofi config.";
        break;;
    esac
  done
  check && $SEPARATOR && scripts
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
  fi
}

finish() {
  $SEPARATOR
  echo -e "${BLUE}Config files are stored in $HOME/repos/dotfiles/cfg/${NC}"
  echo -e "${BLUE}Scripts are stored in $HOME/repos/dotfiles/bin/${NC}"
  echo -e "${RED}If you remove the folder '$HOME/repos/dotfiles/' you will loose the Configs and the Scripts${NC}"
  $SEPARATOR
  echo -e "${GREEN}Script finished :)\n${NC}"
}

change_shell() {
  if (whiptail --title "Fish Shell" --yesno "Do you want to change your user shell to Fish?" 15 60); then
    chsh -s /bin/fish && finish
  else
    finish
  fi
}

configs_yes_no() {
  if (whiptail --title "Config Files" --yesno "Do you want my config files?" 15 60); then
    printf "If you choose yes in the following prompts it will create a symlink in ~/repos/dotfiles/ to ~/.config/\n"
    configs
  else
    scripts
  fi
}

configs_yes_no
