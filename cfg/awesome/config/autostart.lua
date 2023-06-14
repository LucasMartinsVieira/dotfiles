local awful = require("awful")
local user_likes = require("user_vars")

-----------------------
----- Auto Start ------
-----------------------

-- Set the Keyboard Map
-- awful.spawn.with_shell("setxkbmap br")

-- Keep Screen on
awful.spawn.with_shell("xset s off")
awful.spawn.with_shell("xset s off -dpms")

-- Start the compositor
awful.spawn.with_shell("picom")

-- Set a Random Wallpaper
local feh_cmd = "feh --no-fehbg --bg-scale --randomize"
awful.spawn.with_shell(feh_cmd .. " " .. tostring(user_likes.user.wallpapers_dir))

-- Changes color temperature
awful.spawn.with_shell("redshift -P -O 4500")

-- Monitor Config
awful.spawn.with_shell(
"xrandr --output eDP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal")
