local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local theme = require("theme.theme")
local vol1 = require("lib.volume")

-- Volume
local volume = wibox.widget.textbox()
volume.font = beautiful.font .. " 18"

local percentage = wibox.widget.textbox()
percentage.font = beautiful.font .. " 18"

awesome.connect_signal("signal::volume", function(vol, mute)
	vol = tonumber(vol)
	if mute or vol == 0 then
		volume.markup = "<span foreground='"..theme.red.."'>婢</span>"
		percentage.markup = "Muted"
	else
		if vol < 30 then
			volume.markup = "<span foreground='"..theme.blue.."'>ﱜ</span>"
			percentage.markup = vol .. "%"
		elseif vol < 60 then
			volume.markup = "<span foreground='"..theme.blue.."'>奔</span>"
			percentage.markup = vol .. "%"
    else
			volume.markup = "<span foreground='"..theme.blue.."'>墳</span>"
			percentage.markup = vol .. "%"
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

  awful.spawn.easy_async_with_shell(script, function (vol)
    awful.spawn.easy_async_with_shell(script2, function (is_mute)
      if is_mute:match("on") then muted = true else
        muted = false
      end
      vol = tonumber(vol:match("(%d+)"))
    end)
  end)

end

volume:buttons(gears.table.join(
  awful.button({}, 1, function ()
    awful.spawn(vol1.mute())
    volume.get_vol()
  end),
  awful.button({}, 3, function ()
    awful.spawn("pavucontrol")
    volume.get_vol()
  end),
  awful.button({}, 4, function ()
    awful.spawn(vol1.increase())
    volume.get_vol()
  end),
  awful.button({}, 5, function ()
    awful.spawn(vol1.decrease())
    volume.get_vol()
  end)
))

return volume
