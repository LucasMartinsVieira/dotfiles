#!/bin/bash

# INFO: An script for setting up my desktop.

# TODO: Add a function like the one for creating symbolic links for configs files, but for the bash scripts.
# TODO: Change echo's for Whiptail windows in change_shell & scripts functions.

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
	paru --needed --ask 4 -Sy - <pkgs.txt
	paru -S --noconfirm --needed librewolf-bin awesome-git
}

# Creating Symbolic Links from the repo folder to $HOME/.local/bin/
scripts() {
	while true; do
		read -p "Do you want my Rofi/Bash scripts? (y/N)" yn
		case $yn in
		[Yy]*)
			script_yes
			break
			;;
		[Nn]*)
			echo "You choose not to get my Rofi/Bash scripts." && $SEPARATOR
			break
			;;
		*)
			echo "You choose not to get my Rofi/Bash scripts." && $SEPARATOR
			break
			;;
		esac
	done
}

script_yes() {
	mkdir -p $HOME/repos/
	mkdir -p ~/.local/bin/
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

# Function to change the $USER default shell to Bash, Fish or Zsh
change_shell() {
	printf 'Set default user shell (enter number): \n'
	SHELLS=("fish" "bash" "zsh" "quit")
	select choice in "${SHELLS[@]}"; do
		case $choice in
		fish | bash | zsh)
			doas chsh $USER -s "/bin/$choice" &&
				echo -e "$choice has been set as your default USER shell. \
                    \nLogging out is required for this take effect." 
			break
			;;
		quit)
			echo "User quit without changing shell."
			break
			;;
		*)
			echo "invalid option $REPLY"
			;;
		esac
	done
}

# Just a finish messsage
finish() {
	$SEPARATOR
	echo -e "${BLUE}Config files are stored in $HOME/repos/dotfiles/cfg/${NC}"
	echo -e "${BLUE}Scripts are stored in $HOME/repos/dotfiles/bin/${NC}"
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
