local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local user_likes = require("user_vars")
local theme = require "theme.theme"
local helpers = require("helpers")

local wifi = wibox.widget.textbox()
wifi.font = theme.font .. " 18"
helpers.add_hover_cursor(wifi, "hand1")

awesome.connect_signal("signal::wifi", function (net_status)
  if net_status == false then
    wifi.markup = helpers.colorize_text("睊", theme.red)

    wifi:connect_signal("mouse::enter", function()
      wifi.font = theme.font .. " 20"
end)
    wifi:connect_signal("mouse::leave", function()
      wifi.font = theme.font .. " 18"
end)
  else
    wifi.markup = helpers.colorize_text("直", theme.green)

    wifi:connect_signal("mouse::enter", function()
      wifi.font = theme.font .. " 20"
end)
    wifi:connect_signal("mouse::leave", function()
      wifi.font = theme.font .. " 18"
end)
  end
end)

wifi:buttons(gears.table.join(
  awful.button({}, 1, function ()
    awful.spawn(user_likes.apps.terminal_emulator .. " -e nmtui")
  end)
))

return wifi
