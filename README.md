# :sparkles: My Dotfiles

<!-- <div align="center"> -->
<!--     <img src="https://awesomewm.org/images/awesome-logo.svg"> -->
<!-- </div> -->

## Table of Contents

- [Info](#Info)
- [Notes](#Notes)
- [Setup](#Setup)
  - [Services](#services)
- [Configurations](#Configurations)
  - [AwesomeWM](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/awesome)
  - [Neovim](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/nvim)
  - [Kitty](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/kitty)
  - [Lf](https://github.com/LucasMartinsVieira/dotfiles/tree/main/cfg/lf)
  - [Rofi](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/rofi)
  - [Zathura](https://github.com/LucasMartinsVieira/dotfiles/tree/main/cfg/zathura)
- [Licence](#Licence)
- [Credits](#Credits)

## Info

- **OS:** [Arch Linux](archlinux.org)
- **WM:** [Awesome-git](awesomewm.org)
- **Shell:** [Fish](https://fishshell.com/)
- **Terminal:** [Kitty](https://github.com/kovidgoyal/kitty)
- **Editor:** [Neovim](https://github.com/neovim/neovim)
- **Font:** [Jet Brains Mono NF](https://archlinux.org/packages/community/any/ttf-jetbrains-mono-nerd/)
- **Application Launcher:** [Rofi](https://github.com/davatorium/rofi)

## Notes

 - I use ```doas``` instead of ```sudo``` you may want to change that.
 - To get the latest weather updates you need [openweathermap](https://openweathermap.org/) api key.
 
## Setup

I have an [install script](https://github.com/LucasMartinsVieira/dotfiles/blob/main/install.sh) to install my setup. It may or may not work for you.

```
cd
mkdir repos
cd repos
git clone --recurse-submodules https://github.com/LucasMartinsVieira/dotfiles.git
cd dotfiles/
./install.sh
```

### Services

<details close>
    <summary><samp><b>optional services</b></samp></summary>

<br>

```bash
# Enable internet connection
systemctl enable NetworkManager

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

<details close>
    <summary><samp><b>more info</b></samp></summary>

<br>

- [AwesomeWM](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/awesome)
- [Neovim](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/nvim)
- [Kitty](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/kitty)
- [Lf](https://github.com/LucasMartinsVieira/dotfiles/tree/main/cfg/lf)
- [Rofi](https://github.com/LucasMartinsVieira/dotfiles/blob/main/cfg/rofi)
- [Zathura](https://github.com/LucasMartinsVieira/dotfiles/tree/main/cfg/zathura)

<br>

</details>

## Licence

This repo is under the [MIT Licence](https://github.com/LucasMartinsVieira/dotfiles/blob/main/LICENSE)

## Credits

Some parts of my configurations are based on (mainly awesomewm):

- [rklyz](https://github.com/rklyz/MyRice)
- [niraj998](https://github.com/niraj998/awesome)
- [mariod8](https://github.com/mariod8/policromia)
- [Manas140](https://github.com/Manas140/dotfiles)
