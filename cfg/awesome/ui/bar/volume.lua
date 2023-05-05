local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")
local theme = require("theme.theme")
local vol1 = require("lib.volume")

-- Volume
local volume = wibox.widget.textbox()
volume.font = theme.font .. " 18"
helpers.add_hover_cursor(volume, "hand1")

local percentage = wibox.widget.textbox()
percentage.font = theme.font .. " 18"

awesome.connect_signal("signal::volume", function(vol, mute)
  vol = tonumber(vol)
  if mute or vol == 0 then
    volume.markup = helpers.colorize_text("󰝟 ", theme.red)
    percentage.markup = "Muted"

    volume:connect_signal("mouse::enter", function()
      volume.font = theme.font .. " 20"
    end)
    volume:connect_signal("mouse::leave", function()
      volume.font = theme.font .. " 18"
    end)
  else
    if vol <= 30 then
      volume.markup = helpers.colorize_text("󰕿 ", theme.blue)
      percentage.markup = vol .. "%"

      volume:connect_signal("mouse::enter", function()
        volume.font = theme.font .. " 20"
      end)
      volume:connect_signal("mouse::leave", function()
        volume.font = theme.font .. " 18"
      end)
    elseif vol <= 60 then
      volume.markup = helpers.colorize_text("󰖀 ", theme.blue)
      percentage.markup = vol .. "%"

      volume:connect_signal("mouse::enter", function()
        volume.font = theme.font .. " 20"
      end)
      volume:connect_signal("mouse::leave", function()
        volume.font = theme.font .. " 18"
      end)
    else
      volume.markup = helpers.colorize_text("󰕾 ", theme.blue)
      percentage.markup = vol .. "%"

      volume:connect_signal("mouse::enter", function()
        volume.font = theme.font .. " 20"
      end)
      volume:connect_signal("mouse::leave", function()
        volume.font = theme.font .. " 18"
      end)
    end
  end
end)

function volume.get_vol()
  local script = [[
  amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | sed -e 's/%//'
  ]]

  local script2 = [[
  amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }'
  ]]

  awful.spawn.easy_async_with_shell(script, function(vol)
    awful.spawn.easy_async_with_shell(script2, function(is_mute)
      if is_mute:match("on") then
        muted = true
      else
        muted = false
      end
      vol = tonumber(vol:match("(%d+)"))
    end)
  end)
end

volume:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.spawn(vol1.mute())
    vol1.mute_notification()
  end),
  awful.button({}, 3, function()
    awful.spawn("pavucontrol")
  end),
  awful.button({}, 4, function()
    awful.spawn(vol1.increase())
    vol1.notification()
  end),
  awful.button({}, 5, function()
    awful.spawn(vol1.decrease())
    vol1.notification()
  end)
))

return volume
