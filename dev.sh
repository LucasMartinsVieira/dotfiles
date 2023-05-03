#!/bin/bash

SEPARATOR="echo"""

# Colors :
GREEN='\033[0;32m' # Green
BLUE='\033[1;36m'  # Blue
RED='\033[0;31m'   # Red
NC='\033[0m'       # No Color

# Welcome Message.
welcome() {
	echo -e "${BLUE}##########################################################${NC}"
	echo -e "${BLUE}##       Welcome to LucasMartinsVieira dev script       ##${NC}"
	echo -e "${BLUE}##               Press enter to continue                ##${NC}"
	echo -e "${BLUE}##         https://github.com/lucasmartinsvieira        ##${NC}"
	echo -e "${BLUE}##########################################################${NC}"
}
welcome

read

essencial_pkgs() {
	echo -e "${BLUE}###########################################${NC}"
	echo -e "${BLUE}##     Installing essencial Packages     ##${NC}"
	echo -e "${BLUE}###########################################${NC}"

  paru --needed --ask 4 -Sy deno docker docker-compose nodejs npm lazygit prettier stylua shellcheck rustup fd exa zoxide fzf tealdeer bat ripgrep fd

  sleep 3;
  tldr --update
  rust
}

final() {
	echo -e "${GREEN}##################################${NC}"
  echo -e "${GREEN}##     End of the Script :)     ##${NC}"
	echo -e "${GREEN}##################################${NC}"
}

js_tools() {
  doas npm install -g browser-sync
  doas npm i -g vscode-langservers-extracted

	echo -e "${GREEN}JavaScript tools installed.${NC}"
}

npm_packages() {
	while true; do
    read -p "Install JavaScript Development tools?(y/N)" yn
		case $yn in
		[Yy]*)
			js_tools
			break
			;;
		[Nn]*)
			echo "You choose not to install npm Development tools." &&
				$SEPARATOR && final
			break
			;;
		*)
			echo "You choose not to install npm Development tools." && $SEPARATOR && final
			break
			;;
		esac
	done
}

zapzsh() {
	while true; do
    read -p "Install Zap zsh?(y/N)" yn

		case $yn in
		[Yy]*)
			zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
			break
			;;
		[Nn]*)
			echo "You choose not to install Zap zsh." &&
				$SEPARATOR && npm_packages
			break
			;;
		*)
			echo "You choose not to install Zap zsh." && $SEPARATOR && npm_packages
			break
			;;
		esac
	done
}

rust_tools() {
  rustup default stable
  rustup component add rustfmt
  rustup component add clippy

  cargo install cargo-watch

	echo -e "${GREEN}Rustup tools installed.${NC}"
  npm_packages
}

rust() {
	while true; do
    read -p "Install Rust Development tools?(y/N)" yn
		case $yn in
		[Yy]*)
			rust_tools
			break
			;;
		[Nn]*)
			echo "You choose not to install Rust Development tools." &&
				$SEPARATOR && zapzsh
			break
			;;
		*)
			echo "You choose not to install Rust Development tools." && $SEPARATOR && zapzsh
			break
			;;
		esac
	done
}

essencial_pkgs
