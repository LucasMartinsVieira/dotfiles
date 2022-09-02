local awful = require("awful")

-----------------------
----- Auto Start ------
-----------------------

-- Set the Keyboard Map
awful.spawn.with_shell("setxkbmap br")

-- Keep Screen on
awful.spawn.with_shell("xset s off")
awful.spawn.with_shell("xset s off -dpms")

-- Start the compositor
awful.spawn.with_shell("picom")

-- Startup music
awful.spawn.with_shell("mpv --no-video --volume=80 ~/Música/startup/windowsxp.mp3")

-- Set a Random Wallpaper
awful.spawn.with_shell("feh --no-fehbg --bg-scale --randomize --no-xinerama ~/Imagens/Wallpapers/")

-- Monitor Config
awful.spawn.with_shell("xrandr --output LVDS-1 --off --output VGA-1 --primary --mode 1920x1080 --pos 1366x0 --rotate normal --output HDMI-1 --off --output DP-1 --off")
