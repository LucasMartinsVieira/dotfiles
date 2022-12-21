local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local theme = require "theme.theme"

local wifi = wibox.widget.textbox()
wifi.font = theme.font .. " 18"
wifi.markup = "<span foreground='"..theme.green.."'>直 睊</span>"

return wifi
