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

  paru --needed --ask 4 -Sy docker docker-compose nodejs npm lazygit prettier stylua shellcheck rustup fd exa zoxide fzf tlrc-bin bat ripgrep fd github-cli shfmt insomnia-bin jq

  sleep 3
  tldr --update
}

git_config() {
  git config --global user.name "Lucas Martins Vieira"
  git config --global user.email "lucasmartvieira03@outlook.com"
}

gh_cli() {
  gh auth login
}

# mise_config() {
# paru -Sy mise --needed --noconfirm
# asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
#
# response_node=$(curl -s https://nodejs.org/dist/index.json)
# version_lts_node=$(echo "$response_node" | jq -r 'map(select(.lts))[0].version')
# version_latest_node=$(echo "$response_node" | jq -r 'map(select(.version))[0].version')
#
# echo "The current LTS version of Node.js is: $version_lts_node"
# echo "The current LATEST version of Node.js is: $version_latest_node"
# echo ""
# read -rp "Which version of nodejs you want to use? " node_version
#
# mise use -g node@"$node_version"
# echo "$node_version"
# }

rust() {
  rustup default stable
  rustup component add rustfmt
  rustup component add clippy
  rustup component add rust-analyzer

  paru -Sy bacon
}

lsps() {
  paru -Syy eslint_d golines goimports-reviser-bin lua-language-server cargo-binstall taplo-cli yaml-language-server

  cargo binstall --git 'https://github.com/feel-ix-343/markdown-oxide' markdown-oxide

  doas npm install -g @fsouza/prettierd vscode-langservers-extracted typescript-language-server typescript @prisma/language-server @tailwindcss/language-server
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
  # mise_config
  rust
  lsps
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
  # a) mise_config ;;
  r) rust ;;
  j) lsps ;;
  A) all ;;
  *) help ;;
  esac
done
