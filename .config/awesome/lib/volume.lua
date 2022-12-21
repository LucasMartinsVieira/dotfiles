local awful = require("awful")
local naughty = require("naughty")

local volume = {}

volume.notification = function ()
  local script = [[
  amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'
  ]]

  awful.spawn.easy_async_with_shell(script, function(out)
		naughty.notification({
			message = string.format("Volume: %s", out),
			timeout = 0.5,
		})
  end)
end

volume.mute_notification = function ()
  local script = [[
  amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }'
  ]]
  
  awful.spawn.easy_async_with_shell(script, function(out)
		naughty.notification({
			message = string.format("Volume: %s", out),
			timeout = 0.5,
		})
  end)
end

volume.increase = function ()
  local script = [[
  amixer -D pulse sset Master 2%+
  ]]

  awful.spawn(script, false)
  volume.notification()
end

volume.decrease = function ()
  local script = [[
  amixer -D pulse sset Master 2%-
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
