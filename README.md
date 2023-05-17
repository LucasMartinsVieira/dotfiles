# :sparkles: My Dotfiles

![GitHub top language](https://img.shields.io/github/languages/top/lucasmartinsvieira/dotfiles)
![GitHub last commit](https://img.shields.io/github/last-commit/lucasmartinsvieira/dotfiles)
![GitHub](https://img.shields.io/github/license/lucasmartinsvieira/dotfiles)

## Table of Contents

- [Info](#Info)
- [Notes](#Notes)
- [Setup](#Setup)
  - [Services](#services)
- [Configurations](#Configurations)
  - [AwesomeWM](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/awesome)
  - [Neovim](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/nvim)
  - [Scripts](https://github.com/LucasMartinsVieira/dotfiles/blob/main/bin)
- [Licence](#Licence)
- [Credits](#Credits)

## Info

- **OS:** [Arch Linux](archlinux.org)
- **WM:** [Awesome-git](awesomewm.org)
- **Shell:** [Fish](https://fishshell.com/)
- **Terminal:** [Kitty](https://github.com/kovidgoyal/kitty)
- **Editor:** [Neovim](https://github.com/neovim/neovim)
- **Font:** [Jet Brains Mono](https://archlinux.org/packages/community/any/ttf-jetbrains-mono/)
- **Application Launcher:** [Rofi](https://github.com/davatorium/rofi)

## Notes

 - I use ```doas``` instead of ```sudo``` you may want to change that.
 - To get the latest weather updates you need a [openweathermap](https://openweathermap.org/) api key.
 
## Setup

I have an [install script](https://github.com/LucasMartinsVieira/dotfiles/blob/main/install.sh) to install my setup. It may or may not work for you.

```
cd
git clone --recurse-submodules https://github.com/LucasMartinsVieira/dotfiles.git ~/repos/dotfiles/
cd dotfiles/
./install.sh
```

### Services

<details close>
    <summary><samp><b>services</b></samp></summary>

<br>

```bash
# Enable ssh connections
systemctl enable sshd.service

# Enable virtual machine
systemctl enable libvirtd

# Enable printing
systemctl enable cups

# Enable bluetooth
systemctl enable bluetooth
```

</details>

## Configurations

More infos about the config.

- [AwesomeWM](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/awesome)
- [Neovim](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/nvim)
- [Scripts](https://github.com/LucasMartinsVieira/dotfiles/blob/main/bin)

## Licence

This repo is under the [MIT Licence](https://github.com/LucasMartinsVieira/dotfiles/blob/main/LICENSE)

## Credits

Some parts of my configurations are based on:

- [rklyz](https://github.com/rklyz/MyRice)
- [niraj998](https://github.com/niraj998/awesome)
- [mariod8](https://github.com/mariod8/policromia)
- [Manas140](https://github.com/Manas140/dotfiles)
