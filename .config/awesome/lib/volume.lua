local awful = require("awful")
local naughty = require("naughty")
local theme = require("theme.theme")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local volume = {}

volume.notification = function ()
  local script = [[
  amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'
  ]]

  awful.spawn.easy_async_with_shell(script, function(out)
		naughty.notification({
      app_name = "Volume Tool",
			message = string.format("Volume: %s", out),
			timeout = 0.5,
      icon = theme.volume,
      icon_size = dpi(20),
      width = dpi(130),
      height = dpi(50),
		})
  end)
end

volume.mute_notification = function ()
  local script = [[
  amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }'
  ]]
  
  awful.spawn.easy_async_with_shell(script, function(out)
		naughty.notification({
      app_name = "Volume Tool",
			message = string.format("Volume: %s", out),
			timeout = 0.5,
      icon = theme.volume,
      icon_size = dpi(20),
      width = dpi(130),
      height = dpi(50),
		})
  end)
end

volume.increase = function ()
  local script = [[
  amixer -D pulse sset Master 5%+
  ]]

  awful.spawn(script, false)
  volume.notification()
end

volume.decrease = function ()
  local script = [[
  amixer -D pulse sset Master 5%-
  ]]

  awful.spawn(script, false)
  volume.notification()
end

volume.mute = function ()
  local script = [[
  amixer -D pulse sset Master toggle
  ]]
  
  awful.spawn(script, false)
  volume.mute_notification()
end

return volume
