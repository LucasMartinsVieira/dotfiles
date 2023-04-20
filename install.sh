#!/bin/bash

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
welcome

read

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

check_folder

explanation() {
	echo -e "${GREEN}############################################${NC}"
	echo -e "${GREEN}## Installing 'whiptail' if not installed ##${NC}"
	echo -e "${GREEN}############################################${NC}"
	doas pacman -S libnewt --needed --noconfirm
}

explanation

beginning() {
	whiptail --title "Installing Packages!" --msgbox "Installing essential packages (you can see them in 'pkgs.txt') and after them you will have the option of installing optinal packages" 15 60
}

beginning

packages() {
	echo -e "${BLUE}Installing Packages With Paru${NC}"
	paru --needed --ask 4 -Sy - < pkgs.txt && scripts
  paru -S librewolf-bin awesome-git
}

packages

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
	local maxlen
	maxlen="$(getbiggestword "${!checkboxes[@]}")"
	linesize="$(max "$maxlen" 42)"
	local spacer
	spacer="$(replicate "$((linesize - maxlen))" " ")"

	for key in "${!checkboxes[@]}"; do
		# A portable way to check if a command exists in $PATH and is executable.
		# If it doesn't exist, we set the tick box to OFF.
		# If it exists, then we set the tick box to ON.
		if ! command -v "${checkboxes[$key]}" >/dev/null; then
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
		whiptail --title "$title" \
			--checklist "$text" 22 "$((linesize + 16))" 12 \
			"${choices[@]}" \
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
		paru --needed --ask 4 -Sy "$programs" ||
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
	checkboxes["transmission-gtk"]="transmission-gtk"
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
internet
games

scripts() {
	while true; do
		read -p "Do you want my Rofi/Bash scripts? (y/N)" yn
		case $yn in
		[Yy]*)
			script_yes
			break
			;;
		[Nn]*)
			echo "You choose not to get my Rofi/Bash scripts." &&
				$SEPARATOR && change_shell
			break
			;;
		*)
			echo "You choose not to get my Rofi/Bash scripts." && change_shell
			break
			;;
		esac
	done
}

script_yes() {
	mkdir -p $HOME/repos/
	mkdir -p ~/.local/bin/
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
	#alacritty
	while true; do
		read -p "Do you want my alacritty config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/alacritty/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/alacritty/ ~/.config/backup_config
				rm -rf ~/.config/alacritty
				ln -s ~/repos/dotfiles/cfg/alacritty/ ~/.config/alacritty
			else
				ln -s ~/repos/dotfiles/cfg/alacritty/ ~/.config/alacritty
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my alacritty config."
			break
			;;
		*)
			echo "You choose not to get my alacritty config."
			break
			;;
		esac
	done
	$SEPARATOR

	# Awesome
	while true; do
		read -p "Do you want my awesome config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/awesome/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/awesome/ ~/.config/backup_config
				rm -rf ~/.config/awesome/
				ln -s ~/repos/dotfiles/cfg/awesome/ ~/.config/awesome
			else
				ln -s ~/repos/dotfiles/cfg/awesome/ ~/.config/awesome
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my awesome config."
			break
			;;
		*)
			echo "You choose not to get my awesome config."
			break
			;;
		esac
	done
	$SEPARATOR

	# Fish
	while true; do
		read -p "Do you want my fish config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/fish/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/fish/ ~/.config/backup_config
				rm -rf ~/.config/fish/
				ln -s ~/repos/dotfiles/cfg/fish/ ~/.config/fish
			else
				ln -s ~/repos/dotfiles/cfg/fish/ ~/.config/fish
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my fish config."
			break
			;;
		*)
			echo "You choose not to get my fish config."
			break
			;;
		esac
	done
	$SEPARATOR

	# Starship
	while true; do
		read -p "Do you want my Starship config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -f "$HOME/.config/starship.toml" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/starship.toml ~/.config/backup_config
				rm -rf ~/.config/starship.toml
				ln -s ~/repos/dotfiles/cfg/starship.toml ~/.config/starship.toml
			else
				ln -s ~/repos/dotfiles/cfg/starship.toml ~/.config/starship.toml
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my starship config."
			break
			;;
		*)
			echo "You choose not to get my starship config."
			break
			;;
		esac
	done
	$SEPARATOR

	# Kitty
	while true; do
		read -p "Do you want my Kitty config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/kitty/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/kitty/ ~/.config/backup_config
				rm -rf ~/.config/kitty/
				ln -s ~/repos/dotfiles/cfg/kitty/ ~/.config/kitty
			else
				ln -s ~/repos/dotfiles/cfg/kitty/ ~/.config/kitty
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my kitty config."
			break
			;;
		*)
			echo "You choose not to get my kitty config."
			break
			;;
		esac
	done
	$SEPARATOR

	# LF
	while true; do
		read -p "Do you want my LF config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/lf/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/lf/ ~/.config/backup_config
				rm -rf ~/.config/lf/
				ln -s ~/repos/dotfiles/cfg/lf/ ~/.config/lf

				cp -r ~/.config/kitty/ ~/.config/backup_config
				rm -rf ~/.config/lf-ueberzug/
				ln -s ~/repos/dotfiles/cfg/lf-ueberzug/ ~/.config/lf-ueberzug
			else
				ln -s ~/repos/dotfiles/cfg/lf/ ~/.config/lf
				ln -s ~/repos/dotfiles/cfg/lf-ueberzug/ ~/.config/lf-ueberzug
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my lf config."
			break
			;;
		*)
			echo "You choose not to get my lf config."
			break
			;;
		esac
	done
	$SEPARATOR

	# Neovim
	while true; do
		read -p "Do you want my Neovim config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/nvim/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/nvim/ ~/.config/backup_config
				rm -rf ~/.config/nvim/
				ln -s ~/repos/dotfiles/cfg/nvim/ ~/.config/nvim
			else
				ln -s ~/repos/dotfiles/cfg/nvim/ ~/.config/nvim
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my Neovim config."
			break
			;;
		*)
			echo "You choose not to get my Neovim config."
			break
			;;
		esac
	done
	$SEPARATOR

	# Picom
	while true; do
		read -p "Do you want my Picom config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/picom/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/picom/ ~/.config/backup_config
				rm -rf ~/.config/picom/
				ln -s ~/repos/dotfiles/cfg/picom/ ~/.config/picom

				if [ $(pgrep picom) ]; then
					killall picom
					sleep 1
					picom &
				fi

			else
				ln -s ~/repos/dotfiles/cfg/picom/ ~/.config/picom/

				if [ $(pgrep picom) ]; then
					killall picom
					sleep 1
					picom &
				fi
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my picom config."
			break
			;;
		*)
			echo "You choose not to get my picom config."
			break
			;;
		esac
	done
	$SEPARATOR

	# Zathura
	while true; do
		read -p "Do you want my Zathura config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/zathura/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/zathura/ ~/.config/backup_config
				rm -rf ~/.config/zathura/
				ln -s ~/repos/dotfiles/cfg/zathura/ ~/.config/zathura
			else
				ln -s ~/repos/dotfiles/cfg/zathura/ ~/.config/zathura
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my zathura config."
			break
			;;
		*)
			echo "You choose not to get my zathura config."
			break
			;;
		esac
	done
	$SEPARATOR

	# Rofi
	while true; do
		read -p "Do you want my Rofi config? (y/N)" yn
		case $yn in
		[Yy]*)
			if [ -d "$HOME/.config/rofi/" ]; then
				mkdir -p ~/.config/backup_config
				cp -r ~/.config/rofi/ ~/.config/backup_config
				rm -rf ~/.config/rofi
				ln -s ~/repos/dotfiles/cfg/rofi/ ~/.config/rofi
			else
				ln -s ~/repos/dotfiles/cfg/rofi/ ~/.config/rofi
			fi
			break
			;;
		[Nn]*)
			echo "You choose not to get my Rofi config."
			break
			;;
		*)
			echo "You choose not to get my Rofi config."
			break
			;;
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

finish() {
	$SEPARATOR
	echo -e "${BLUE}Config files are stored in $HOME/repos/dotfiles/cfg/${NC}"
	echo -e "${BLUE}Scripts are stored in $HOME/repos/dotfiles/bin/${NC}"
	echo -e "${RED}If you remove the folder '$HOME/repos/dotfiles/' you will loose the Configs and the Scripts${NC}"
	$SEPARATOR
	echo -e "${GREEN}Script finished :)\n${NC}"
}

change_shell() {
	printf 'Set default user shell (enter number): \n'
	SHELLS=("fish" "bash" "zsh" "quit")
	select choice in "${SHELLS[@]}"; do
		case $choice in
		fish | bash | zsh)
			doas chsh $USER -s "/bin/$choice" &&
				echo -e "$choice has been set as your default USER shell. \
                    \nLogging out is required for this take effect."
			finish
			break
			;;
		quit)
			echo "User quit without changing shell."
			finish
			break
			;;
		*)
			echo "invalid option $REPLY"
			;;
		esac
	done
}

configs_yes_no() {
	$SEPARATOR
	while true; do
		read -p "Do you want my config files? (y/N)" yn
		case $yn in
		[Yy]*)
			configs
			break
			;;
		[Nn]*)
			echo "You choose not to get my config files."
			scripts
			break
			;;
		*)
			echo "You choose not to get my config files."
			scripts
			break
			;;
		esac
	done
}

configs_yes_no
