local _M = {}

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

_M.volume = wibox.widget.textbox()

_M.volume_icon = wibox.widget {
  text = "墳",
  font = "JetBrains Mono 18",
  ellipsize = "none",
  widget = wibox.widget.textbox,
}

function _M.update_volume()
  local command =
    "amixer sget Master | grep 'Right:' | awk '{print $5 $6}' | sed -e 's/\\[//' -e 's/\\]//' -e 's/\\[//' -e 's/\\]//'"
  awful.spawn.easy_async_with_shell(command, function(out)
    _M.volume.text = string.format(" %s ", out)
  end)
end

function _M.show_volume_percent_notification()
	local command = "amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'"
	awful.spawn.easy_async_with_shell(command, function(out)
		naughty.notification({
			message = string.format("Volume: %s", out),
			timeout = 0.5,
		})
    _M.update_volume()
	end)
end

function _M.show_switch_notification()
  local command = "amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }'"
  awful.spawn.easy_async_with_shell(command, function(out)
    naughty.notification({
      message = string.format("Volume: %s", out),
      timeout = 0.5,
    })
    _M.update_volume()
  end)
end

_M.volume:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.spawn("amixer -D pulse sset Master toggle")
      _M.update_volume()
    end),
    awful.button({}, 3, function()
      awful.spawn("pavucontrol")
      _M.update_volume()
    end),
    awful.button({}, 4, function()
      awful.spawn("amixer -D pulse sset Master 2%+")
      _M.show_volume_percent_notification()
      _M.update_volume()
    end),
    awful.button({}, 5, function()
      awful.spawn("amixer -D pulse sset Master 2%-")
      _M.update_volume()
      _M.show_volume_percent_notification()
    end)
))

_M.volume_icon:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.spawn("amixer -D pulse sset Master toggle")
      _M.update_volume()
    end),
    awful.button({}, 3, function()
      awful.spawn("pavucontrol")
      _M.update_volume()
    end),
    awful.button({}, 4, function()
      awful.spawn("amixer -D pulse sset Master 2%+")
      _M.show_volume_percent_notification()
      _M.update_volume()
    end),
    awful.button({}, 5, function()
      awful.spawn("amixer -D pulse sset Master 2%-")
      _M.update_volume()
      _M.show_volume_percent_notification()
    end)
))

_M.update_volume()

return _M
