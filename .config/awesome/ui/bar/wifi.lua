local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local applications = require("config.applications")
local theme = require "theme.theme"
local helpers = require("helpers")

local wifi = wibox.widget.textbox()
wifi.font = theme.font .. " 18"

awesome.connect_signal("signal::wifi", function (net_status)
  if net_status == false then
    wifi.markup = helpers.colorize_text("睊", theme.red)
  else
    wifi.markup = helpers.colorize_text("直", theme.green)
  end
end)

wifi:buttons(gears.table.join(
  awful.button({}, 1, function ()
    awful.spawn(applications.default.terminal_emulator .. " -e nmtui")
  end)
))

return wifi
