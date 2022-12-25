local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local applications = require("config.applications")
local theme = require "theme.theme"

local wifi = wibox.widget.textbox()
wifi.font = theme.font .. " 18"

awesome.connect_signal("signal::wifi", function (net_status)
  if net_status == false then
    wifi.markup = "<span foreground='"..theme.red.."'>睊</span>"
  else
    wifi.markup = "<span foreground='"..theme.green.."'>直</span>"
  end
end)

wifi:buttons(gears.table.join(
  awful.button({}, 1, function ()
    awful.spawn(applications.default.terminal_emulator .. " -e nmtui")
  end)
))

return wifi
