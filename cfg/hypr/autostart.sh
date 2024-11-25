#!/usr/bin/env bash

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# waybar &
dunst &

eww daemon
eww open-many bar0 bar1

wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

swww init
wallpaper ~/Pictures/Wallpapers/ --randomize &
# swww img -o eDP-1,HDMI-A-1 ~/Imagens/Wallpapers/wallpapers0019.jpg
wlsunset -t 3200 -T 3201 &
