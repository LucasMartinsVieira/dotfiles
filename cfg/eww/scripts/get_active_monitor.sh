#!/usr/bin/env bash

active_monitor() {
   hyprctl activewindow -j | jq '.monitor'
}

active_monitor
