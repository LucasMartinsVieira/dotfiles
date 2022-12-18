local _M = {}

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local calendar_widget = require("ui.calendar")
local calendar = calendar_widget()
local icons_dir = require("gears").filesystem.get_configuration_dir() .."/theme/assets/"
require("ui.dashboard")

_M.awful_icon = wibox.widget {
  image = icons_dir .. "dragon-svgrepo-com.svg",
  resize = true,
  widget = wibox.widget.imagebox, visible = true, clip_shape = gears.shape.rectangle,
  buttons = {
    awful.button({}, 1, nil, function ()
      if dashboard.visible == false then
        dashboard.visible = true
      else
        dashboard.visible = false
      end
    end)
  }
}

-- Textclock widget
_M.mytextclock = wibox.widget {
  format = "%H:%M",
  widget = wibox.widget.textclock
}

_M.mytextclock:buttons(gears.table.join(
  awful.button({}, 1, nil, function ()
    calendar.toggle()
  end)
))

_M.mytextclock_icon = wibox.widget {
   text = "",
   font = "JetBrains Mono 18",
   ellipsize = "none",
   widget = wibox.widget.textbox,
}

_M.mytextclock_icon:buttons(gears.table.join(
  awful.button({}, 1, nil, function ()
    calendar.toggle()
  end)
))

-- Username
_M.username = awful.widget.watch("whoami", 1)

-- Keyboard widget
_M.mykeyboardlayout = awful.widget.keyboardlayout()

return _M
