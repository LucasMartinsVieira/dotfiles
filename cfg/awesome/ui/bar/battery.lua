local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme.theme")
local helpers = require("helpers")
local icons = require("utils.icons")

-- Battery
local battery = wibox.widget.textbox()
battery.font = theme.font .. " 14"
helpers.add_hover_cursor(battery, "hand1")

-- Hover Effect
battery:connect_signal("mouse::enter", function()
  battery.font = theme.font .. " 16"
end)
battery:connect_signal("mouse::leave", function()
  battery.font = theme.font .. " 14"
end)

awesome.connect_signal("signal::battery", function(bat_level)
  bat_level = tonumber(bat_level)

  if bat_level <= 10 then
    battery.markup = helpers.colorize_text(icons.battery.ten, theme.red)
  elseif bat_level <= 20 then
    battery.markup = helpers.colorize_text(icons.battery.twenty, theme.red)
  elseif bat_level <= 30 then
    battery.markup = helpers.colorize_text(icons.battery.thirty, theme.red)
  elseif bat_level <= 40 then
    battery.markup = helpers.colorize_text(icons.battery.forty, theme.green)
  elseif bat_level <= 50 then
    battery.markup = helpers.colorize_text(icons.battery.fifty, theme.green)
  elseif bat_level <= 60 then
    battery.markup = helpers.colorize_text(icons.battery.sixty, theme.green)
  elseif bat_level <= 70 then
    battery.markup = helpers.colorize_text(icons.battery.seventy, theme.green)
  elseif bat_level <= 80 then
    battery.markup = helpers.colorize_text(icons.battery.eighty, theme.green)
  elseif bat_level <= 90 then
    battery.markup = helpers.colorize_text(icons.battery.ninety, theme.green)
  else
    battery.markup = helpers.colorize_text(icons.battery.hundred, theme.green)
  end
end)

return battery
