local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme.theme")
local helpers = require("helpers")

-- Battery
local battery = wibox.widget.textbox()
battery.font = theme.font .. " 20"

-- Hover Effect
battery:connect_signal("mouse::enter", function()
  battery.font = theme.font .. " 22"
end)
battery:connect_signal("mouse::leave", function()
  battery.font = theme.font .. " 20"
end)

awesome.connect_signal("signal::battery", function(bat_level)
  bat_level = tonumber(bat_level)

  if bat_level <= 20 then
    battery.markup = helpers.colorize_text("", theme.red)
  elseif bat_level <= 40 then
    battery.markup = helpers.colorize_text("", theme.green)
  elseif bat_level <= 60 then
    battery.markup = helpers.colorize_text("", theme.green)
  elseif bat_level <= 80 then
    battery.markup = helpers.colorize_text("", theme.green)
    else
    battery.markup = helpers.colorize_text("", theme.green)
  end
end)

return battery
