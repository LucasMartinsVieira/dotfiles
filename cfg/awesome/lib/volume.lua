local awful = require("awful")
local naughty = require("naughty")
local theme = require("theme.theme")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local volume = {}
-- amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'

volume.notification = function()
  local script = [[
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}'
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

volume.mute_notification = function()
  -- awesome.connect_signal("signal:volume", function(mute)
  --   if mute then
  --     out = "ON"
  --   else
  --     out = "OFF"
  --   end
  -- end)

  local script = [[
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}'
  ]]

  awful.spawn.easy_async_with_shell(script, function(out)
    if string.len(out) ~= 1 then
      out = "OFF"
    else
      out = "ON"
    end

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

volume.increase = function()
  local script = [[
  wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+
  ]]

  awful.spawn(script, false)
end

volume.decrease = function()
  local script = [[
  wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 2%-
  ]]

  awful.spawn(script, false)
end

volume.mute = function()
  local script = [[
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  ]]

  awful.spawn(script, false)
end

return volume
