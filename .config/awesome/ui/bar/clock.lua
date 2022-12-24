local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme = require("theme.theme")
local calendar_widget = require("ui.calendar")
local calendar = calendar_widget()

local clock = wibox.widget {
  format = "%a %d %b, %H:%M",
  font = theme.font,
  widget = wibox.widget.textclock
}

clock:buttons(gears.table.join(
  awful.button({}, 1, nil, function ()
    calendar.toggle()
  end)
))

return clock
