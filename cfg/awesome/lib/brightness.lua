local awful = require("awful")
local naughty = require("naughty")
local theme = require("theme.theme")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local brightness = {}

brightness.notification = function ()
  local script = [[
  brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-0)}'
  ]]

  awful.spawn.easy_async_with_shell(script, function(out)
		naughty.notification({
      app_name = "Brightness Tool",
			message = string.format("Brightness: %s", out),
			timeout = 0.5,
      icon = theme.brightness,
      icon_size = dpi(20),
      width = dpi(130),
      height = dpi(50),
		})
  end)
end

brightness.increase = function ()
  local script = [[
  brightnessctl set 5%+ -q
  ]]

  awful.spawn(script, false)
end

brightness.decrease = function ()
  local script = [[
  brightnessctl set 5%- -q
  ]]

  awful.spawn(script, false)
end

return brightness
