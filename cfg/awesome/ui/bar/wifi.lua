local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local user_likes = require("user_vars")
local theme = require("theme.theme")
local helpers = require("helpers")
local icons = require("utils.icons")

local wifi = wibox.widget.textbox()
wifi.font = theme.font .. " 14"
helpers.add_hover_cursor(wifi, "hand1")

awesome.connect_signal("signal::wifi", function(net_strengh)
  net_strengh = tonumber(net_strengh)

  if net_strengh == 0 then
    wifi.markup = helpers.colorize_text(icons.wifi_off, theme.red)
    wifi:connect_signal("mouse::enter", function()
      wifi.font = theme.font .. " 16"
    end)
    wifi:connect_signal("mouse::leave", function()
      wifi.font = theme.font .. " 14"
    end)
  else
    wifi.markup = helpers.colorize_text(icons.wifi_on, theme.green)
    wifi:connect_signal("mouse::enter", function()
      wifi.font = theme.font .. " 16"
    end)
    wifi:connect_signal("mouse::leave", function()
      wifi.font = theme.font .. " 14"
    end)
  end
end)

wifi:buttons(gears.table.join(awful.button({}, 1, function()
  awful.spawn(user_likes.apps.terminal_emulator .. " -e nmtui")
end)))

return wifi
