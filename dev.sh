#!/bin/bash

SEPARATOR="echo"""

# Colors :
GREEN='\033[0;32m' # Green
BLUE='\033[1;36m'  # Blue
RED='\033[0;31m'   # Red
NC='\033[0m'       # No Color

welcome() {
	echo -e "${BLUE}##########################################################${NC}"
	echo -e "${BLUE}##       Welcome to LucasMartinsVieira dev script       ##${NC}"
	echo -e "${BLUE}##               Press enter to continue                ##${NC}"
	echo -e "${BLUE}##         https://github.com/lucasmartinsvieira        ##${NC}"
	echo -e "${BLUE}##########################################################${NC}"

	read -r
}

packages() {
	echo -e "${BLUE}###########################################${NC}"
	echo -e "${BLUE}##     Installing essencial Packages     ##${NC}"
	echo -e "${BLUE}###########################################${NC}"

	paru --needed --ask 4 -Sy deno docker docker-compose nodejs npm lazygit prettier stylua shellcheck rustup fd exa zoxide fzf tealdeer bat ripgrep fd github-cli shfmt insomnia-bin

	sleep 3
	tldr --update
}

git_config() {
	git config --global user.name "LucasMartinsVieira"
	git config --global user.email "lucasmartvieira03@outlook.com"
}

gh_cli() {
	gh auth login
}

asdf_config() {
	paru -Sy asdf-vm --needed --noconfirm
}

rust() {
	rustup default stable
	rustup component add rustfmt
	rustup component add clippy

	cargo install cargo-watch
}

javascript() {
	doas npm install -g live-server
	doas npm i -g vscode-langservers-extracted
}

final() {
	echo -e "${GREEN}##################################${NC}"
	echo -e "${GREEN}##     End of the Script :)     ##${NC}"
	echo -e "${GREEN}##################################${NC}"
}

all() {
	welcome
	packages
	git_config
	gh_cli
	asdf_config
	rust
	javascript
	final
}

help() {
	echo -e "${BLUE}Available Options${NC}"
	echo -e "p) packages ;;"
	echo -e "g) git_config ;;"
	echo -e "G) gh_cli ;;"
	echo -e "a) asdf_config ;;"
	echo -e "r) rust ;;"
	echo -e "j) javascript ;;"
	echo -e "A) all ;;"
}

while getopts "hpgGarjA" arg 2>/dev/null; do
	case "${arg}" in
	h) help ;;
	p) packages ;;
	g) git_config ;;
	G) gh_cli ;;
	a) asdf_config ;;
	r) rust ;;
	j) javascript ;;
	A) all ;;
	*) help ;;
	esac
done
