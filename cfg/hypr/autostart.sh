#!/usr/bin/env bash

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
waybar &
dunst &
nm-applet &
blueman-applet &

wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

swww init
swww img -o eDP-1,HDMI-A-1 ~/Imagens/Wallpapers/wallpapers0019.jpg
